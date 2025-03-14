#!/bin/bash
set -e

# Ensure the script is executable with: chmod +x setup.sh

if [ ! -f ".env.local" ]; then
  echo "Creating .env.local from example..."
  cp .env.example .env.local
fi

# Install dependencies with fallbacks for different package managers
echo "Installing dependencies..."
if command -v pnpm &> /dev/null; then
  pnpm install
elif command -v yarn &> /dev/null; then
  yarn install
else
  npm install
fi

echo "✅ Project ready! Run 'npm run dev' to start the development server"

# Provide additional information about Supabase setup
echo ""
echo "🔑 Don't forget to configure your Supabase credentials in .env.local:"
echo "NEXT_PUBLIC_SUPABASE_URL=your-project-url"
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key"