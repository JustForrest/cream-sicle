#!/bin/bash
set -e

echo "🔧 Setting up development environment..."

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Set up Supabase if needed
echo "Setting up Supabase local development..."
npx supabase init

# Create .env.local from example if it doesn't exist
if [ ! -f ".env.local" ]; then
  echo "📝 Creating .env.local from example..."
  cp .env.example .env.local
  echo "Please update .env.local with your actual Supabase credentials"
fi

# Make setup.sh executable for additional configuration if needed
chmod +x setup.sh

echo "✅ Environment setup complete!"
echo "🚀 Run 'npm run dev' to start the development server"
echo "💡 For additional configuration and checks, run './setup.sh'"

# Print success message
echo "Post-creation setup completed successfully!"