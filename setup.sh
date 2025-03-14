if [ ! -f ".env.local" ]; then
  echo "Creating .env.local from example..."
  cp .env.example .env.local
fi

echo "Installing dependencies..."
npm install

echo "✅ Project ready! Run 'npm run dev' to start the development server"