#!/bin/bash

# VS Code WakaTime Extension Installer
echo "📦 Installing WakaTime Extension for VS Code"
echo "============================================="

# Check if VS Code is installed
if command -v code &> /dev/null; then
    echo "✅ VS Code found"
    
    # Install WakaTime extension
    echo "🚀 Installing WakaTime extension..."
    code --install-extension WakaTime.vscode-wakatime
    
    if [ $? -eq 0 ]; then
        echo "✅ WakaTime extension installed successfully!"
        echo ""
        echo "📋 Next Steps:"
        echo "1. Restart VS Code"
        echo "2. You'll be prompted for your WakaTime API key"
        echo "3. Enter the API key you got from https://wakatime.com/api-key"
        echo ""
        echo "🔧 Manual Configuration (if needed):"
        echo "1. Open VS Code"
        echo "2. Press Ctrl+Shift+P (Cmd+Shift+P on Mac)"
        echo "3. Type 'WakaTime: API Key'"
        echo "4. Enter your API key when prompted"
    else
        echo "❌ Failed to install WakaTime extension"
        echo "Please install it manually:"
        echo "1. Open VS Code"
        echo "2. Go to Extensions (Ctrl+Shift+X)"
        echo "3. Search for 'WakaTime'"
        echo "4. Install the WakaTime extension"
    fi
else
    echo "❌ VS Code not found. Please install VS Code first:"
    echo "Visit: https://code.visualstudio.com/download"
    echo ""
    echo "Or install via snap:"
    echo "sudo snap install --classic code"
    echo ""
    echo "Other editors supported by WakaTime:"
    echo "• JetBrains IDEs (IntelliJ, PyCharm, etc.)"
    echo "• Vim/Neovim"
    echo "• Atom"
    echo "• Sublime Text"
    echo "• And many more: https://wakatime.com/plugins"
fi

echo ""
echo "🎯 What WakaTime Will Track:"
echo "• Time spent coding in different languages"
echo "• Projects you work on"
echo "• Operating systems used"
echo "• Code editors used"
echo "• Daily/weekly coding patterns"
echo ""
echo "📈 Data will appear in your GitHub profile after:"
echo "• Setting up the GitHub Action secrets"
echo "• Coding for a few hours with the extension active"
echo "• The daily GitHub Action runs (12 AM IST)"
