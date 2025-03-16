#!/bin/bash
set -e

echo "Setting executable permissions on scripts..."

# Set permissions for all scripts in the .devcontainer/scripts directory
chmod +x "$PWD/.devcontainer/scripts/"*.sh

# Set permissions for any scripts in the root directory
if ls "$PWD/"*.sh 1> /dev/null 2>&1; then
  chmod +x "$PWD/"*.sh
fi

echo "✅ Permissions set successfully"