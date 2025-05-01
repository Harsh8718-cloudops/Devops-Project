#!/bin/bash

set -e  # Exit if any command fails

PROJECT_DIR="01-springboot-bankapp-with-docker-compose"
NESTED_DIR="${PROJECT_DIR}/Springboot-BankApp"

echo "✅ Starting cleanup and restructuring..."

# Check if nested directory exists
if [ ! -d "$NESTED_DIR" ]; then
    echo "❌ Error: $NESTED_DIR not found."
    exit 1
fi

# Move all files and directories except .git
echo "📦 Moving files from $NESTED_DIR to $PROJECT_DIR..."
shopt -s dotglob  # include hidden files
for item in "$NESTED_DIR"/*; do
    if [[ "$(basename "$item")" != ".git" ]]; then
        mv "$item" "$PROJECT_DIR/"
    fi
done

# Delete .git in nested folder
if [ -d "$NESTED_DIR/.git" ]; then
    echo "🧹 Deleting nested .git folder..."
    rm -rf "$NESTED_DIR/.git"
fi

# Delete the now-empty Springboot-BankApp directory
echo "🧽 Removing empty $NESTED_DIR..."
rmdir "$NESTED_DIR"

echo "✅ Restructuring complete!"
echo "👉 Now run the following commands to commit the changes:"
echo "   cd $PROJECT_DIR"
echo "   git add ."
echo "   git commit -m 'Flattened structure by moving Springboot-BankApp contents up'"
echo "   git push origin main  # or your current branch"

echo "🚀 Done! Your project structure is now flat."