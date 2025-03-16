#!/bin/bash
set -e

echo "🔧 Setting up development environment..."

# Ensure setup script is executable
chmod +x ./setup.sh

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Run the main setup script
echo "🔄 Running main setup script..."
./setup.sh

echo "✅ Environment setup complete!"
echo "🚀 Run 'npm run dev' to start the development server"

# Print success message
echo "Post-creation setup completed successfully!"
