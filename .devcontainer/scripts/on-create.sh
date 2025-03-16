#!/bin/bash
set -e

echo "Running onCreateCommand script..."

# Install dependencies using npm ci for reproducible builds
npm ci

# Install Vercel Speed Insights
npm i @vercel/speed-insights

# Note: Keep this script focused on operations safe for pre-builds
# Don't include environment-specific configurations here
echo "onCreateCommand completed successfully"