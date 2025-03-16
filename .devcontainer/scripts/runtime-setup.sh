#!/bin/bash
set -e

echo "Running runtime setup..."

# This script only runs in non-prebuild contexts
# Focus on environment-specific setup

# Create .env.local if it doesn't exist (centralize this operation here only)
if [ ! -f ".env.local" ]; then
  echo "Creating .env.local from example file"
  cp .env.example .env.local
  echo "⚠️ Please update .env.local with your Supabase credentials"
fi

# Start services that shouldn't run during prebuild
# supabase start

echo "Runtime setup completed"