#!/bin/bash
set -e

# Check if the script is executable
if [ ! -x "$(realpath $0)" ]; then
  echo "❌ This script is not executable. Run the following command to make it executable:"
  echo "chmod +x $(basename $0)"
  exit 1
fi

# Check Supabase CLI version
check_supabase_cli() {
  if ! command -v supabase &> /dev/null; then
    echo "⚠️ Supabase CLI not found. Some features might not work properly."
    echo "To install, follow instructions at: https://supabase.com/docs/guides/cli"
    return
  fi
  
  local min_version="1.115.0"
  local current_version=$(supabase --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
  
  if [[ "$(printf '%s\n' "$min_version" "$current_version" | sort -V | head -n1)" != "$min_version" ]]; then
    echo "⚠️ Your Supabase CLI version ($current_version) is older than the recommended version ($min_version)."
    echo "Consider upgrading for better compatibility."
  else
    echo "✅ Supabase CLI version $current_version is compatible."
  fi
}

# Run version check
check_supabase_cli

# Ensure the script is executable with: chmod +x setup.sh

if [ ! -f ".env.local" ]; then
  echo "Creating .env.local from example..."
  cp .env.example .env.local
fi

# Install dependencies with npm
echo "📦 Installing dependencies with npm..."
npm install

echo "✅ Project ready! Run 'npm run dev' to start the development server"

# Provide additional information about Supabase setup
echo ""
echo "🔑 Don't forget to configure your Supabase credentials in .env.local:"
echo "NEXT_PUBLIC_SUPABASE_URL=your-project-url"
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key"