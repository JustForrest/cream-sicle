#!/bin/bash
set -e

echo "Running setup script..."

# Check if running in prebuild context
if [ "$CODESPACES_PREBUILD" == "true" ]; then
  echo "Running in prebuild context, skipping environment-specific setup"
  
  # Only run performance-critical setup
  echo "Pre-compiling dependencies..."
  # Add any prebuild optimizations here
  
else
  # Run full setup including environment configuration
  echo "Setting up full development environment"
  
  # Setup GitHub CLI extensions if needed
  echo "Setting up GitHub CLI extensions"
  # Add any gh extensions here
  
  # Start local services if needed
  echo "Starting local services..."
  # Add commands to start services
fi

echo "Setup script completed"