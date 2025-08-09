# 🕒 WakaTime Integration for Real-Time Coding Statistics

This guide will help you set up WakaTime to track your coding activity and display real-time statistics in your GitHub profile.

## 🚀 Quick Start

1. **Run the setup script**:
   ```bash
   ./setup_wakatime.sh
   ```

2. **Install VS Code extension** (if using VS Code):
   ```bash
   ./install_vscode_wakatime.sh
   ```

3. **Add GitHub secrets** (detailed instructions in the setup script output)

## 📊 What WakaTime Will Show in Your Profile

Once configured, your GitHub profile will display:

### ⏱️ Time Statistics
- **Daily average coding time**
- **Weekly breakdown** of coding hours
- **Total time coded** since tracking began
- **Most productive day** of the week
- **Peak coding hours** during the day

### 💻 Technology Breakdown
- **Programming languages** with time percentages
- **Code editors** used (VS Code, IntelliJ, etc.)
- **Operating systems** (Linux, Windows, macOS)
- **Projects** you've worked on
- **Categories** of development work

### 📈 Visual Charts
- **Language usage pie chart**
- **Weekly activity bar chart**
- **Daily coding pattern heatmap**
- **Productivity trends** over time

## 🛠️ Setup Process

### Step 1: Create WakaTime Account
1. Go to [wakatime.com/signup](https://wakatime.com/signup)
2. Sign up with your GitHub account
3. Verify your email address

### Step 2: Get Your API Key
1. Visit [wakatime.com/api-key](https://wakatime.com/api-key)
2. Copy your API key (format: `waka_1234567890abcdef`)

### Step 3: Configure Local Environment
```bash
# Run the setup script
./setup_wakatime.sh

# Follow the prompts to enter your API key
```

### Step 4: Install Editor Extensions

#### VS Code
```bash
# Automated installation
./install_vscode_wakatime.sh

# Manual installation
# 1. Open VS Code
# 2. Go to Extensions (Ctrl+Shift+X)
# 3. Search for "WakaTime"
# 4. Install and enter your API key
```

#### Other Editors
- **IntelliJ IDEA**: File → Settings → Plugins → Browse repositories → WakaTime
- **Vim**: [wakatime-vim](https://github.com/wakatime/vim-wakatime)
- **Atom**: Settings → Install → Search "wakatime"
- **Sublime Text**: Package Control → Install Package → WakaTime

### Step 5: GitHub Repository Configuration

#### Add Secrets
1. Go to your repository: `https://github.com/DarrylClay2005/DarrylClay2005/settings/secrets/actions`
2. Add these secrets:

**Secret 1:**
- Name: `WAKATIME_API_KEY`
- Value: Your WakaTime API key

**Secret 2:**
- Name: `GH_TOKEN`
- Value: GitHub Personal Access Token

#### Create GitHub Personal Access Token
1. Go to [github.com/settings/tokens](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Set name: "WakaTime Profile Stats"
4. Select scopes:
   - ☑️ `repo` (Full control of private repositories)
   - ☑️ `workflow` (Update GitHub Action workflows)
5. Copy the generated token

## 🔧 GitHub Action Configuration

The GitHub Action will run:
- **Daily** at 12:00 AM IST
- **Manually** when you trigger it
- **On push** to update workflow changes

### Manual Trigger
1. Go to [GitHub Actions](https://github.com/DarrylClay2005/DarrylClay2005/actions)
2. Click "Waka Readme" workflow
3. Click "Run workflow"

## 📊 Expected Profile Updates

After setup, your README will show sections like:

```
📊 This Week I Spent My Time On:

⌚︎ Time Zone: Asia/Kolkata

💬 Programming Languages:
JavaScript   8 hrs 15 mins   ████████████████░░░░░   65.23%
Python       2 hrs 45 mins   ████████░░░░░░░░░░░░░   21.78%
HTML         1 hr 2 mins     ████░░░░░░░░░░░░░░░░░   8.19%
CSS          35 mins         ██░░░░░░░░░░░░░░░░░░░   4.65%

🔥 Editors:
VS Code      10 hrs 30 mins  ████████████████████░   83.22%
IntelliJ     2 hrs 7 mins    ████░░░░░░░░░░░░░░░░░   16.78%

🐱‍💻 Projects:
animeverse-app    5 hrs 23 mins   ██████████████░░░░░░░   42.67%
wakatime-stats    3 hrs 12 mins   █████████░░░░░░░░░░░░   25.43%
portfolio         2 hrs 1 min     ████░░░░░░░░░░░░░░░░░   16.02%

💻 Operating System:
Linux        12 hrs 37 mins  ████████████████████░   100.0%
```

## 🕐 Timeline

- **Immediate**: Local tracking starts after editor extension installation
- **1-2 hours**: First data appears in WakaTime dashboard
- **24 hours**: GitHub Action runs and updates profile
- **1 week**: Meaningful weekly statistics available

## 🔍 Troubleshooting

### Common Issues

#### WakaTime Not Tracking
- ✅ Check editor extension is installed and active
- ✅ Verify API key is correct in editor settings
- ✅ Ensure you're actively coding (not just browsing)

#### GitHub Action Failing
- ✅ Check both secrets (`WAKATIME_API_KEY` and `GH_TOKEN`) are set
- ✅ Verify GitHub token has correct permissions
- ✅ Check GitHub Actions tab for specific error messages

#### No Data in Profile
- ✅ Wait 24-48 hours for initial data collection
- ✅ Manually trigger the GitHub Action
- ✅ Verify WakaTime dashboard shows your activity

### Verification Steps

1. **Check WakaTime Dashboard**: [wakatime.com/dashboard](https://wakatime.com/dashboard)
2. **Test Local CLI**: 
   ```bash
   /home/desmond/.local/bin/wakatime --today
   ```
3. **Check GitHub Actions**: Repository → Actions tab
4. **View Raw Data**: WakaTime provides JSON API for verification

## 🎨 Customization Options

### Modify Display Settings
Edit `.github/workflows/waka-readme.yml` to change:
- `SHOW_PROJECTS: "True/False"` - Show/hide project breakdown
- `SHOW_OS: "True/False"` - Show/hide OS statistics  
- `SHOW_EDITORS: "True/False"` - Show/hide editor usage
- `SHOW_LANGUAGE: "True/False"` - Show/hide language stats
- `SHOW_COMMIT: "True/False"` - Show/hide commit statistics

### Theme Options
The WakaTime stats will automatically match your profile's dark theme.

## 📚 Additional Resources

- **WakaTime Dashboard**: [wakatime.com/dashboard](https://wakatime.com/dashboard)
- **API Documentation**: [wakatime.com/developers](https://wakatime.com/developers)
- **Plugin List**: [wakatime.com/plugins](https://wakatime.com/plugins)
- **GitHub Action Source**: [anmol098/waka-readme-stats](https://github.com/anmol098/waka-readme-stats)

## 🎯 Privacy & Data

- **Local tracking**: Extensions only track file types and project names
- **No code content**: WakaTime never sees your actual code
- **Public stats**: Only aggregated time statistics are shown in your profile
- **Full control**: You can disable tracking anytime in editor settings

---

Your coding statistics will start appearing in your GitHub profile within 24 hours of setup completion! 📊✨
