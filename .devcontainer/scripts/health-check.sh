#!/bin/bash

# Health check script for services
check_service() {
  local service=$1
  local check_command=$2
  local max_attempts=${3:-5}
  local delay=${4:-3}
  
  echo "Checking $service..."
  
  for ((i=1; i<=max_attempts; i++)); do
    if eval "$check_command"; then
      echo "✅ $service is ready"
      return 0
    else
      echo "⏳ $service not ready, attempt $i/$max_attempts"
      sleep $delay
    fi
  done
  
  echo "❌ $service failed health check after $max_attempts attempts"
  return 1
}

# Check if services are running
if [ "$CODESPACES_PREBUILD" != "true" ]; then
  # Check Next.js development server
  if pgrep -f "next dev" > /dev/null; then
    check_service "Next.js server" "curl -s http://localhost:3000 > /dev/null" 5 2
  fi
  
  # Check Supabase
  if command -v supabase &> /dev/null; then
    check_service "Supabase" "supabase status | grep -q 'online'" 5 3
  fi
fi

# Report overall status
echo "Environment health check completed"