#!/bin/sh
#
# DeepSeek Harness Desktop App Installer
# Installs DeepSeek-Harness.app to /Applications
# Usage: curl ... | sh

set -e

echo "=========================================="
echo "  DeepSeek Harness Desktop Installer"
echo "=========================================="
echo

# Check if we're on macOS
if [ "$(uname -s)" != "Darwin" ]; then
    echo "Error: This installer only works on macOS."
    exit 1
fi

# Check if npx is available
if ! command -v npx >/dev/null 2>&1; then
    echo "Error: npx is required but not found."
    echo "Please install Node.js first: https://nodejs.org/"
    exit 1
fi

# Check if @deepseek-ai/dsh is available
echo "Checking DeepSeek Harness..."
if ! npx @deepseek-ai/dsh --help >/dev/null 2>&1; then
    echo "Installing @deepseek-ai/dsh from npm..."
    npm install -g @deepseek-ai/dsh
fi

APP_NAME="DeepSeek-Harness.app"
TARGET_DIR="/Applications"
GITHUB_REPO="https://github.com/Aussi12/DSH-Desktop-Launcher/releases/latest/download"
DOWNLOAD_URL="$GITHUB_REPO/DeepSeek-Harness.dmg"

echo
echo "Downloading DeepSeek-Harness.app..."
cd /tmp
curl --fail --silent --show-error -L -o DeepSeek-Harness.dmg "$DOWNLOAD_URL"

echo "Mounting disk image..."
hdiutil attach -quiet DeepSeek-Harness.dmg

echo "Installing to $TARGET_DIR..."
cp -R "/Volumes/DeepSeek Harness/$APP_NAME" "$TARGET_DIR/"

echo "Cleaning up..."
hdiutil detach -quiet "/Volumes/DeepSeek Harness"
rm -f DeepSeek-Harness.dmg

echo
echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo
echo "You can now launch DeepSeek Harness from:"
echo "  $TARGET_DIR/$APP_NAME"
echo
echo "Double-click the app to start DeepSeek Harness."
echo