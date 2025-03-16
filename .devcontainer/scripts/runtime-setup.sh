#!/bin/bash
set -e

echo "Running runtime setup..."

# This script only runs in non-prebuild contexts
# Focus on environment-specific setup

# Only start services when not in prebuild
if [ "$CODESPACES_PREBUILD" != "true" ]; then
  echo "Starting Supabase services..."
  
  # Start Supabase with timeout and retry
  MAX_RETRIES=3
  RETRY_COUNT=0
  
  while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    supabase start && break
    RETRY_COUNT=$((RETRY_COUNT+1))
    echo "Retrying Supabase start ($RETRY_COUNT/$MAX_RETRIES)..."
    sleep 5
  done
  
  if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo "⚠️ Failed to start Supabase after $MAX_RETRIES attempts"
    echo "Please run 'supabase start' manually once setup completes"
  else
    echo "✅ Supabase services started successfully"
  fi
  
  # Display connection information
  supabase status
fi

# Setup environment variables if needed
if [ ! -f "$PWD/.env.local" ]; then
  echo "Creating .env.local from example file"
  # Check if example file exists
  if [ -f "$PWD/.env.example" ]; then
    cp "$PWD/.env.example" "$PWD/.env.local"
  else
    # Create a basic .env.local if no example exists
    cat > "$PWD/.env.local" << EOF
# Update these with your Supabase details from your project settings > API
NEXT_PUBLIC_SUPABASE_URL=your-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
EOF
  fi
  
  # Extract and display Supabase credentials if available
  if command -v supabase &> /dev/null && [ "$CODESPACES_PREBUILD" != "true" ]; then
    SUPABASE_URL=$(supabase status | grep 'API URL' | awk '{print $3}')
    SUPABASE_KEY=$(supabase status | grep 'anon key' | awk '{print $3}')
    
    if [ -n "$SUPABASE_URL" ] && [ -n "$SUPABASE_KEY" ]; then
      # Update .env.local with actual values
      sed -i "s|NEXT_PUBLIC_SUPABASE_URL=.*|NEXT_PUBLIC_SUPABASE_URL=$SUPABASE_URL|g" "$PWD/.env.local"
      sed -i "s|NEXT_PUBLIC_SUPABASE_ANON_KEY=.*|NEXT_PUBLIC_SUPABASE_ANON_KEY=$SUPABASE_KEY|g" "$PWD/.env.local"
      echo "✅ Updated .env.local with Supabase credentials"
    else
      echo "⚠️ Please update .env.local with your Supabase credentials"
    fi
  fi
fi

# Start supabase
echo "Starting Supabase..."
cd /workspaces/cream-sicle
npx supabase start

# Start Next.js in the background
echo "Starting Next.js development server..."
cd /workspaces/cream-sicle
nohup npm run dev > /tmp/nextjs.log 2>&1 &

echo "Development environment is ready!"

echo "Runtime setup completed"