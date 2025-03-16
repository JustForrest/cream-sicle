#!/bin/bash
set -e

echo "Running setup script..."

# Check if running in prebuild context
if [ "$CODESPACES_PREBUILD" == "true" ]; then
  echo "Running in prebuild context, skipping environment-specific setup"
  
  # Only run performance-critical setup
  echo "Setting up Supabase CLI in pre-build environment"
  npm install -g supabase
  
  # Pre-compile dependencies or other prebuild optimization steps
  echo "Pre-compiling dependencies..."
  # Add any prebuild optimizations here
  
else
  # Run full setup including environment configuration
  echo "Setting up full development environment"
  
  # Setup Supabase CLI
  echo "Setting up Supabase CLI"
  npm install -g supabase
  
  # Setup GitHub CLI extensions if needed
  echo "Setting up GitHub CLI extensions"
  # Add any gh extensions here
  
  # Start local services if needed
  echo "Starting local services..."
  # Add commands to start services

  echo "🔧 Running comprehensive setup script..."

  # Check if the script is executable
  if [ ! -x "$(realpath $0)" ]; then
    echo "❌ This script is not executable. Run the following command to make it executable:"
    echo "chmod +x $(basename $0)"
    exit 1
  fi

  # Check Supabase CLI version if installed
  if command -v supabase &> /dev/null; then
    SUPABASE_VERSION=$(supabase --version)
    echo "✅ Supabase CLI detected: $SUPABASE_VERSION"
  else
    echo "⚠️ Supabase CLI not found. If needed, install via npm install -g supabase"
  fi

  # Create .env.local from example if it doesn't exist
  if [ ! -f ".env.local" ]; then
    echo "📝 Creating .env.local from example..."
    cp .env.example .env.local
    echo "⚠️ Please update .env.local with your actual Supabase credentials"
  else
    echo "✅ .env.local file already exists"
  fi

  # Verify node_modules exists
  if [ ! -d "node_modules" ]; then
    echo "⚠️ node_modules not found. Running npm install..."
    npm install
  else
    echo "✅ Dependencies already installed."
  fi

  # Set up Supabase local development if needed
  # echo "Setting up Supabase local development..."
  # npx supabase init

  echo "✅ Setup completed successfully!"
fi

echo "Setup script completed"