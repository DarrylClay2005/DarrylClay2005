#!/bin/bash

# WakaTime Integration Setup Script
# This script will guide you through setting up WakaTime for your GitHub profile

echo "🚀 WakaTime Integration Setup for GitHub Profile"
echo "================================================="
echo ""

# Check if WakaTime CLI is installed
if ! command -v /home/desmond/.local/bin/wakatime &> /dev/null; then
    echo "❌ WakaTime CLI not found. Please run the installation first."
    exit 1
fi

echo "✅ WakaTime CLI is installed (version: $(/home/desmond/.local/bin/wakatime --version))"
echo ""

# Step 1: Account Setup Instructions
echo "📋 STEP 1: Create WakaTime Account"
echo "-----------------------------------"
echo "1. Go to: https://wakatime.com/signup"
echo "2. Sign up with your GitHub account or email"
echo "3. Verify your email address"
echo ""
echo "📋 STEP 2: Get Your API Key"
echo "----------------------------"
echo "1. Go to: https://wakatime.com/api-key"
echo "2. Copy your API key (it looks like: waka_1234567890abcdef)"
echo ""

# Prompt for API key
read -p "🔑 Enter your WakaTime API key: " WAKATIME_API_KEY

if [ -z "$WAKATIME_API_KEY" ]; then
    echo "❌ No API key provided. Please run the script again with your API key."
    exit 1
fi

# Configure WakaTime
echo ""
echo "🔧 Configuring WakaTime..."
mkdir -p ~/.wakatime
echo "[settings]" > ~/.wakatime/.wakatime.cfg
echo "api_key = $WAKATIME_API_KEY" >> ~/.wakatime/.wakatime.cfg
echo "✅ WakaTime configuration saved to ~/.wakatime/.wakatime.cfg"

# Step 3: GitHub Secrets Setup Instructions
echo ""
echo "📋 STEP 3: GitHub Repository Secrets Setup"
echo "-------------------------------------------"
echo "Now you need to add secrets to your GitHub repository:"
echo ""
echo "1. Go to: https://github.com/DarrylClay2005/DarrylClay2005/settings/secrets/actions"
echo "2. Click 'New repository secret'"
echo "3. Add these two secrets:"
echo ""
echo "   Secret Name: WAKATIME_API_KEY"
echo "   Secret Value: $WAKATIME_API_KEY"
echo ""
echo "4. Click 'Add secret'"
echo "5. Click 'New repository secret' again"
echo "6. Add the second secret:"
echo ""
echo "   Secret Name: GH_TOKEN"
echo "   Secret Value: [You need to create a GitHub Personal Access Token]"
echo ""
echo "📋 STEP 4: Create GitHub Personal Access Token"
echo "-----------------------------------------------"
echo "1. Go to: https://github.com/settings/tokens"
echo "2. Click 'Generate new token (classic)'"
echo "3. Give it a name like 'WakaTime Profile Stats'"
echo "4. Set expiration to 'No expiration' or desired duration"
echo "5. Select these scopes:"
echo "   ☑ repo (Full control of private repositories)"
echo "   ☑ workflow (Update GitHub Action workflows)"
echo "6. Click 'Generate token'"
echo "7. Copy the token and add it as GH_TOKEN secret in your repository"
echo ""

# Step 4: VS Code Extension Installation
echo "📋 STEP 5: Install Editor Extensions"
echo "------------------------------------"
echo "For VS Code (if you use it):"
echo "1. Open VS Code"
echo "2. Go to Extensions (Ctrl+Shift+X)"
echo "3. Search for 'WakaTime'"
echo "4. Install the WakaTime extension"
echo "5. Enter your API key when prompted: $WAKATIME_API_KEY"
echo ""
echo "For other editors, visit: https://wakatime.com/plugins"
echo ""

# Test WakaTime
echo "🧪 Testing WakaTime Configuration..."
if /home/desmond/.local/bin/wakatime --today > /dev/null 2>&1; then
    echo "✅ WakaTime is configured correctly!"
else
    echo "⚠️  WakaTime test failed. Please check your API key and try again."
fi

echo ""
echo "📊 STEP 6: Trigger GitHub Action"
echo "--------------------------------"
echo "The GitHub Action will automatically run daily, but you can trigger it manually:"
echo "1. Go to: https://github.com/DarrylClay2005/DarrylClay2005/actions"
echo "2. Click on 'Waka Readme' workflow"
echo "3. Click 'Run workflow'"
echo "4. Click the green 'Run workflow' button"
echo ""

echo "🎉 Setup Complete!"
echo "==================="
echo "Your WakaTime integration is configured. Here's what happens next:"
echo ""
echo "✅ WakaTime will track your coding activity"
echo "✅ GitHub Action will update your profile daily at 12 AM IST"
echo "✅ Your README will show coding time, languages, and projects"
echo ""
echo "⏱️  Note: It may take a few days to collect enough data for meaningful statistics."
echo ""
echo "🔍 Troubleshooting:"
echo "   - Check GitHub Actions tab for any errors"
echo "   - Ensure both secrets (WAKATIME_API_KEY and GH_TOKEN) are set correctly"
echo "   - Make sure editor extensions are installed and working"
echo ""
echo "📖 View your updated profile at: https://github.com/DarrylClay2005"
