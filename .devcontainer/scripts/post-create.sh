#!/bin/bash
set -e

echo "🔧 Setting up development environment..."

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Run the main setup script which will handle all configuration
echo "🔄 Running main setup script..."
./setup.sh

echo "✅ Environment setup complete!"
echo "🚀 Run 'npm run dev' to start the development server"

# Print success message
echo "Post-creation setup completed successfully!"
