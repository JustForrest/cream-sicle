#!/bin/bash
set -e

echo "🔧 Setting up development environment..."

# Create .env.local from example if it doesn't exist
if [ ! -f ".env.local" ]; then
  echo "📝 Creating .env.local from example..."
  cp .env.example .env.local
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Make setup.sh executable for additional configuration if needed
chmod +x setup.sh

echo "✅ Environment setup complete!"
echo "🚀 Run 'npm run dev' to start the development server"
echo "💡 For additional configuration and checks, run './setup.sh'"