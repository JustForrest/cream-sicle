#!/bin/bash
set -e

echo "Running runtime setup..."

# This script handles runtime-specific setup that should happen
# after the container has been created or rebuilt

# Check if running in prebuild context
if [ "$CODESPACES_PREBUILD" == "true" ]; then
  echo "Running in prebuild context, performing minimal setup"
  # Do minimal setup necessary for pre-build
else
  echo "Setting up runtime environment"
  
  # Start services or perform other runtime initializations
  # that shouldn't happen during prebuild
  
  # Example: Initialize development database
  # supabase start

  # Only run environment-specific setup like .env.local creation
  if [ ! -f ".env.local" ]; then
    cp .env.example .env.local
    echo "⚠️ Please update .env.local with your Supabase credentials"
  fi
fi

echo "Runtime setup completed"