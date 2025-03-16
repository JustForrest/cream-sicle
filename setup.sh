#!/bin/bash
set -e

echo "🔍 Running additional setup and verification checks..."

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

# Verify .env.local exists and has proper values
if [ ! -f ".env.local" ]; then
  echo "⚠️ .env.local file not found. Creating from example..."
  cp .env.example .env.local
  echo "⚠️ Please update your Supabase credentials in .env.local"
else
  # Check if .env.local has default values
  if grep -q "your-project-url\|your-anon-key" .env.local; then
    echo "⚠️ Your .env.local file contains default values. Please update with actual Supabase credentials."
  else
    echo "✅ .env.local file exists with custom values."
  fi
fi

# Verify node_modules exists
if [ ! -d "node_modules" ]; then
  echo "⚠️ node_modules not found. Running npm install..."
  npm install
else
  echo "✅ Dependencies already installed."
fi

echo "✅ Verification complete!"
echo ""
echo "🔑 Don't forget to verify your Supabase credentials in .env.local:"
echo "NEXT_PUBLIC_SUPABASE_URL=your-project-url"
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key"