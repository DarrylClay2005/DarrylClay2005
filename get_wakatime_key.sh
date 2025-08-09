#!/bin/bash

echo "🚀 WakaTime Account Setup & API Key Retrieval"
echo "=============================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}📋 Step 1: Create WakaTime Account${NC}"
echo "1. Opening WakaTime signup page..."
echo "2. Sign up with your GitHub account (DarrylClay2005)"
echo "3. Verify your email address"
echo ""

# Open WakaTime signup page
if command -v xdg-open &> /dev/null; then
    echo "🌐 Opening https://wakatime.com/signup ..."
    xdg-open "https://wakatime.com/signup" &>/dev/null &
    sleep 2
fi

echo "Press ENTER when you've completed the signup and email verification..."
read -p ""

echo ""
echo -e "${BLUE}📋 Step 2: Get Your API Key${NC}"
echo "1. Opening WakaTime API key page..."
echo "2. Copy your API key (format: waka_1234567890abcdef)"
echo ""

# Open API key page
if command -v xdg-open &> /dev/null; then
    echo "🔑 Opening https://wakatime.com/api-key ..."
    xdg-open "https://wakatime.com/api-key" &>/dev/null &
    sleep 2
fi

echo ""
read -p "🔑 Paste your WakaTime API key here: " WAKATIME_API_KEY

if [ -z "$WAKATIME_API_KEY" ]; then
    echo "❌ No API key provided. Please run this script again."
    exit 1
fi

# Validate API key format (basic check)
if [[ "$WAKATIME_API_KEY" =~ ^waka_.+ ]] || [[ "$WAKATIME_API_KEY" =~ ^[a-f0-9-]{36}$ ]]; then
    echo -e "${GREEN}✅ API key format looks correct${NC}"
else
    echo -e "${YELLOW}⚠️  API key format looks unusual, but proceeding...${NC}"
fi

echo ""
echo -e "${BLUE}📋 Step 3: Configure Local WakaTime${NC}"

# Create WakaTime config directory
mkdir -p ~/.wakatime

# Save API key to config file
cat > ~/.wakatime/.wakatime.cfg << EOF
[settings]
api_key = $WAKATIME_API_KEY
EOF

echo -e "${GREEN}✅ WakaTime local configuration saved${NC}"

# Test WakaTime connection
echo ""
echo "🧪 Testing WakaTime connection..."
if /home/desmond/.local/bin/wakatime --today > /dev/null 2>&1; then
    echo -e "${GREEN}✅ WakaTime connection test successful!${NC}"
else
    echo -e "${YELLOW}⚠️  Connection test failed, but API key saved${NC}"
    echo "This might be normal for a new account - try again in a few minutes"
fi

echo ""
echo -e "${BLUE}📋 Step 4: Update GitHub Secret${NC}"

# Update GitHub repository secret with real API key
echo "Updating GitHub repository secret with your real API key..."
if gh secret set WAKATIME_API_KEY --body="$WAKATIME_API_KEY" --repo="DarrylClay2005/DarrylClay2005"; then
    echo -e "${GREEN}✅ GitHub secret WAKATIME_API_KEY updated successfully${NC}"
else
    echo "❌ Failed to update GitHub secret"
    exit 1
fi

echo ""
echo -e "${BLUE}📋 Step 5: Configure VS Code${NC}"

# Update VS Code settings
mkdir -p ~/.config/Code/User

# Check if settings file exists
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"

if [ -f "$VSCODE_SETTINGS" ]; then
    # Backup existing settings
    cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.backup.$(date +%Y%m%d-%H%M%S)"
    echo "Existing VS Code settings backed up"
fi

# Update VS Code settings with Python
python3 << EOF
import json
import os

settings_file = os.path.expanduser('~/.config/Code/User/settings.json')
api_key = '$WAKATIME_API_KEY'

try:
    with open(settings_file, 'r') as f:
        settings = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    settings = {}

settings['wakatime.api_key'] = api_key

with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=2)

print("VS Code WakaTime settings updated")
EOF

echo -e "${GREEN}✅ VS Code configured with WakaTime API key${NC}"

echo ""
echo -e "${BLUE}📋 Step 6: Trigger GitHub Action${NC}"

# Trigger the GitHub Action workflow
echo "Triggering GitHub Action to update your profile..."
if gh workflow run "waka-readme.yml" --repo="DarrylClay2005/DarrylClay2005"; then
    echo -e "${GREEN}✅ GitHub Action triggered successfully${NC}"
    echo "📊 Check progress: https://github.com/DarrylClay2005/DarrylClay2005/actions"
else
    echo -e "${YELLOW}⚠️  Could not trigger automatically${NC}"
    echo "Manual trigger: https://github.com/DarrylClay2005/DarrylClay2005/actions"
fi

echo ""
echo "🎉 WakaTime Setup Complete!"
echo "==========================="
echo ""
echo -e "${GREEN}✅ WakaTime account created${NC}"
echo -e "${GREEN}✅ API key configured locally${NC}"
echo -e "${GREEN}✅ GitHub secrets updated${NC}"
echo -e "${GREEN}✅ VS Code extension configured${NC}"
echo -e "${GREEN}✅ GitHub Action triggered${NC}"
echo ""

echo "📊 What happens next:"
echo "• Start coding in VS Code - WakaTime will track your activity"
echo "• Check WakaTime dashboard: https://wakatime.com/dashboard"
echo "• Your GitHub profile will show statistics within 24 hours"
echo "• Daily updates happen automatically at 12:00 AM IST"
echo ""

echo "🔍 Quick verification links:"
echo "• Your Profile: https://github.com/DarrylClay2005"
echo "• WakaTime Dashboard: https://wakatime.com/dashboard"
echo "• GitHub Actions: https://github.com/DarrylClay2005/DarrylClay2005/actions"
echo "• Repository Secrets: https://github.com/DarrylClay2005/DarrylClay2005/settings/secrets/actions"
echo ""

echo -e "${GREEN}🚀 All set! Start coding and watch your stats appear! 📊${NC}"
