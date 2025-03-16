#!/bin/bash
set -e

echo "Running setup script..."

# Check if running in prebuild context
if [ "$CODESPACES_PREBUILD" == "true" ]; then
  echo "Running in prebuild context, optimizing environment..."
  
  # Install dependencies for all workspaces
  echo "Pre-installing dependencies..."
  npm ci
  
  # Build packages that can be pre-compiled
  echo "Pre-compiling packages..."
  npm run build || echo "Build step skipped - may require environment variables"
  
  # Cache Next.js build outputs
  if [ -d ".next" ]; then
    echo "Caching Next.js build output..."
    mkdir -p .prebuild-cache
    cp -R .next .prebuild-cache/
  fi
  
  # Run type checking to warm up TypeScript
  echo "Warming up TypeScript..."
  npx tsc --noEmit || echo "TypeScript check completed with warnings"
else
  # Run full setup including environment configuration
  echo "Setting up development environment..."
  
  # Restore cached build outputs if available
  if [ -d ".prebuild-cache/.next" ]; then
    echo "Restoring cached Next.js build..."
    mkdir -p .next
    cp -R .prebuild-cache/.next/* .next/
  fi
  
  # Setup environment-specific configurations
  ./runtime-setup.sh
fi

echo "Setup script completed"