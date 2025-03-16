# New runtime-setup.sh
#!/bin/bash
# Only run environment-specific setup like .env.local creation
if [ ! -f ".env.local" ]; then
  cp .env.example .env.local
  echo "⚠️ Please update .env.local with your Supabase credentials"
fi