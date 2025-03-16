#!/bin/bash
set -e

echo "Running postCreateCommand script..."

# Import the setup logic
source .devcontainer/scripts/setup.sh

# Additional post-creation tasks that should happen after setup
echo "Setting up environment files..."

# Copy example env file if .env.local doesn't exist
if [ ! -f .env.local ]; then
  echo "Creating .env.local from example file"
  cp .env.example .env.local
fi

echo "postCreateCommand completed successfully"
