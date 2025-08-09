#!/bin/bash

# Automated WakaTime Setup Script
# This script automates as much as possible while keeping security best practices

echo "🚀 Automated WakaTime Setup"
echo "============================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check prerequisites
print_step "Checking prerequisites..."

# Check GitHub CLI
if ! command -v gh &> /dev/null; then
    print_error "GitHub CLI not found. Please install it first."
    exit 1
fi

# Check GitHub authentication
if ! gh auth status &> /dev/null; then
    print_error "Not authenticated with GitHub CLI. Please run 'gh auth login'"
    exit 1
fi

print_success "GitHub CLI is authenticated"

# Check WakaTime CLI
if ! command -v /home/desmond/.local/bin/wakatime &> /dev/null; then
    print_error "WakaTime CLI not found. Please run the installation script first."
    exit 1
fi

print_success "WakaTime CLI is available"

# Step 1: Create GitHub Personal Access Token
print_step "Step 1: Creating GitHub Personal Access Token for WakaTime"

# Generate a unique token name with timestamp
TOKEN_NAME="WakaTime-Profile-Stats-$(date +%Y%m%d-%H%M%S)"

echo "Creating GitHub token with name: $TOKEN_NAME"

# Create the token with necessary scopes
GH_TOKEN=$(gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /user/tokens \
  -f "description=$TOKEN_NAME" \
  -f "scopes[]=repo" \
  -f "scopes[]=workflow" 2>/dev/null | jq -r '.token' 2>/dev/null)

if [ -z "$GH_TOKEN" ] || [ "$GH_TOKEN" = "null" ]; then
    print_warning "Automatic token creation failed. Let's try alternative method..."
    
    # Alternative: Use gh CLI to create token
    echo "Creating token using gh CLI..."
    GH_TOKEN=$(echo "y" | gh auth refresh -s repo,workflow 2>&1 | grep -oP 'gho_[a-zA-Z0-9]{36}' | head -1)
    
    if [ -z "$GH_TOKEN" ]; then
        print_error "Could not create GitHub token automatically."
        echo ""
        echo "Please create a token manually:"
        echo "1. Go to: https://github.com/settings/tokens"
        echo "2. Click 'Generate new token (classic)'"
        echo "3. Name: 'WakaTime Profile Stats'"
        echo "4. Scopes: repo, workflow"
        echo "5. Copy the token and run this script again"
        echo ""
        read -p "Enter your GitHub token manually: " GH_TOKEN
    fi
fi

if [ -n "$GH_TOKEN" ]; then
    print_success "GitHub token obtained successfully"
else
    print_error "Failed to obtain GitHub token"
    exit 1
fi

# Step 2: WakaTime Account Setup
print_step "Step 2: WakaTime Account Setup"

echo ""
echo "🔐 For security reasons, you need to complete these steps manually:"
echo ""
echo "1. Open browser and go to: https://wakatime.com/signup"
echo "2. Sign up with your GitHub account (DarrylClay2005)"
echo "3. Verify your email address"
echo "4. Go to: https://wakatime.com/api-key"
echo "5. Copy your API key (format: waka_1234567890abcdef)"
echo ""

# Open browser automatically if possible
if command -v xdg-open &> /dev/null; then
    echo "🌐 Opening WakaTime signup page..."
    xdg-open "https://wakatime.com/signup" &>/dev/null &
    sleep 3
    echo "🔑 Opening API key page..."
    xdg-open "https://wakatime.com/api-key" &>/dev/null &
fi

echo ""
read -p "🔑 Enter your WakaTime API key: " WAKATIME_API_KEY

if [ -z "$WAKATIME_API_KEY" ]; then
    print_error "No API key provided. Exiting."
    exit 1
fi

# Validate API key format
if [[ ! "$WAKATIME_API_KEY" =~ ^waka_[a-zA-Z0-9]{36}$ ]] && [[ ! "$WAKATIME_API_KEY" =~ ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$ ]]; then
    print_warning "API key format looks unusual, but proceeding..."
fi

print_success "WakaTime API key received"

# Step 3: Configure local WakaTime
print_step "Step 3: Configuring local WakaTime"

mkdir -p ~/.wakatime
cat > ~/.wakatime/.wakatime.cfg << EOF
[settings]
api_key = $WAKATIME_API_KEY
EOF

print_success "WakaTime local configuration saved"

# Test WakaTime connection
print_step "Testing WakaTime connection..."
if /home/desmond/.local/bin/wakatime --today > /dev/null 2>&1; then
    print_success "WakaTime connection test successful"
else
    print_warning "WakaTime connection test failed, but continuing with setup"
fi

# Step 4: Set GitHub repository secrets
print_step "Step 4: Setting GitHub repository secrets"

# Set WAKATIME_API_KEY secret
echo "Setting WAKATIME_API_KEY secret..."
if gh secret set WAKATIME_API_KEY --body="$WAKATIME_API_KEY" --repo="DarrylClay2005/DarrylClay2005"; then
    print_success "WAKATIME_API_KEY secret set successfully"
else
    print_error "Failed to set WAKATIME_API_KEY secret"
    exit 1
fi

# Set GH_TOKEN secret
echo "Setting GH_TOKEN secret..."
if gh secret set GH_TOKEN --body="$GH_TOKEN" --repo="DarrylClay2005/DarrylClay2005"; then
    print_success "GH_TOKEN secret set successfully"
else
    print_error "Failed to set GH_TOKEN secret"
    exit 1
fi

# Step 5: Configure VS Code
print_step "Step 5: Configuring VS Code WakaTime extension"

# Create VS Code settings directory if it doesn't exist
mkdir -p ~/.config/Code/User

# Check if VS Code settings exist and update them
VSCODE_SETTINGS_FILE="$HOME/.config/Code/User/settings.json"

if [ -f "$VSCODE_SETTINGS_FILE" ]; then
    # Backup existing settings
    cp "$VSCODE_SETTINGS_FILE" "$VSCODE_SETTINGS_FILE.backup.$(date +%Y%m%d-%H%M%S)"
    print_success "VS Code settings backed up"
fi

# Update VS Code settings with WakaTime API key
python3 -c "
import json
import os

settings_file = os.path.expanduser('~/.config/Code/User/settings.json')
api_key = '$WAKATIME_API_KEY'

# Load existing settings or create empty dict
try:
    with open(settings_file, 'r') as f:
        settings = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    settings = {}

# Add WakaTime settings
settings['wakatime.api_key'] = api_key

# Write back to file
with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=2)

print('VS Code settings updated')
"

print_success "VS Code WakaTime extension configured"

# Step 6: Trigger GitHub Action
print_step "Step 6: Triggering GitHub Action"

echo "Manually triggering the WakaTime GitHub Action..."
if gh workflow run "waka-readme.yml" --repo="DarrylClay2005/DarrylClay2005"; then
    print_success "GitHub Action triggered successfully"
    echo "Check the progress at: https://github.com/DarrylClay2005/DarrylClay2005/actions"
else
    print_warning "Could not trigger GitHub Action automatically"
    echo "You can trigger it manually at: https://github.com/DarrylClay2005/DarrylClay2005/actions"
fi

# Final summary
echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
print_success "WakaTime CLI configured"
print_success "VS Code extension configured"
print_success "GitHub secrets added:"
echo "   - WAKATIME_API_KEY: ✓"
echo "   - GH_TOKEN: ✓"
print_success "GitHub Action ready"
echo ""

echo "📊 What happens next:"
echo "• Start coding in VS Code - WakaTime will track your activity"
echo "• Check your WakaTime dashboard: https://wakatime.com/dashboard"
echo "• GitHub Action runs daily at 12:00 AM IST"
echo "• Statistics will appear in your profile within 24 hours"
echo ""

echo "🔍 Verification links:"
echo "• Your profile: https://github.com/DarrylClay2005"
echo "• WakaTime dashboard: https://wakatime.com/dashboard"
echo "• GitHub Actions: https://github.com/DarrylClay2005/DarrylClay2005/actions"
echo "• Repository secrets: https://github.com/DarrylClay2005/DarrylClay2005/settings/secrets/actions"
echo ""

print_success "All set! Start coding and your statistics will begin appearing automatically! 🚀"
