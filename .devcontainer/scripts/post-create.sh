#!/bin/bash
set -e

echo "Running postCreateCommand script..."

# Import the setup logic with prebuild detection
source .devcontainer/scripts/setup.sh

# Call runtime-setup only if not in prebuild mode
if [ "$CODESPACES_PREBUILD" != "true" ]; then
  source .devcontainer/scripts/runtime-setup.sh
fi

echo "postCreateCommand completed successfully"
