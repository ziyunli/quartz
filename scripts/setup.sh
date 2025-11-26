#!/bin/sh
# ABOUTME: Setup script to configure git hooks and install dependencies.
# ABOUTME: Run this after cloning the repo to enable pre-commit formatting.

set -e

echo "Setting up quartz..."

# Configure git to use the .githooks directory
git config core.hooksPath .githooks

echo "✓ Git hooks configured"

# Check if prettier is available
if ! command -v npx >/dev/null 2>&1; then
    echo "⚠ npx not found. Please install Node.js first."
    exit 1
fi

echo "✓ Setup complete!"
echo ""
echo "Pre-commit hook will now format content files before each commit."
