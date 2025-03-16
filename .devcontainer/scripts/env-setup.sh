#!/bin/bash
set -e

ENV_TEMPLATE=".env.example"
ENV_FILE=".env.local"

echo "Setting up environment variables..."

# Don't override existing .env.local unless forced
if [ -f "$ENV_FILE" ] && [ "$1" != "--force" ]; then
  echo "ℹ️ $ENV_FILE already exists. Use --force to override."
else
  # Create from template
  cp "$ENV_TEMPLATE" "$ENV_FILE"
  echo "✅ Created $ENV_FILE from template"
  
  # If running in development context, try to populate with real values
  if [ "$CODESPACES_PREBUILD" != "true" ] && command -v supabase &> /dev/null; then
    # Wait for Supabase to be fully started
    echo "Waiting for Supabase services..."
    for i in {1..10}; do
      if supabase status | grep -q 'online'; then
        break
      fi
      echo "Waiting for Supabase to start... ($i/10)"
      sleep 3
    done
    
    # Extract connection details
    SUPABASE_URL=$(supabase status | grep 'API URL' | awk '{print $3}')
    SUPABASE_KEY=$(supabase status | grep 'anon key' | awk '{print $3}')
    
    if [ -n "$SUPABASE_URL" ] && [ -n "$SUPABASE_KEY" ]; then
      # Update environment file
      sed -i "s|NEXT_PUBLIC_SUPABASE_URL=.*|NEXT_PUBLIC_SUPABASE_URL=$SUPABASE_URL|g" "$ENV_FILE"
      sed -i "s|NEXT_PUBLIC_SUPABASE_ANON_KEY=.*|NEXT_PUBLIC_SUPABASE_ANON_KEY=$SUPABASE_KEY|g" "$ENV_FILE"
      echo "✅ Updated $ENV_FILE with actual Supabase credentials"
    else
      echo "⚠️ Could not get Supabase credentials, manual configuration required"
    fi
  else
    echo "⚠️ Please update $ENV_FILE with your service credentials"
  fi
fi

# Validate required variables
MISSING=0
while IFS= read -r line; do
  if [[ $line =~ ^[A-Z_]+=$ ]]; then
    VAR_NAME=$(echo "$line" | cut -d= -f1)
    echo "⚠️ Missing required value for $VAR_NAME in $ENV_FILE"
    MISSING=$((MISSING+1))
  fi
done < "$ENV_FILE"

if [ $MISSING -gt 0 ]; then
  echo "⚠️ Found $MISSING empty environment variables that need to be configured"
else
  echo "✅ All environment variables have values"
fi