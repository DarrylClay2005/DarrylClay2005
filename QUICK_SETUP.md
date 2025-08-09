# 🚀 WakaTime Quick Setup Checklist

## ✅ Completed
- [x] WakaTime CLI installed (v1.130.1)
- [x] VS Code WakaTime extension installed (v25.3.0)
- [x] GitHub Actions workflow configured
- [x] Setup scripts ready

## 🔄 Next Steps (Do These Now)

### 1. Create WakaTime Account
📱 **Open in browser:** https://wakatime.com/signup
- Sign up with GitHub account
- Verify email address

### 2. Get Your API Key
📱 **Open in browser:** https://wakatime.com/api-key
- Copy your API key (looks like: `waka_1234567890abcdef`)

### 3. Configure VS Code
- **Open VS Code**
- You'll see a WakaTime prompt for API key
- **Enter your API key** from step 2
- Or press `Ctrl+Shift+P` → type "WakaTime: API Key"

### 4. Add GitHub Secrets
📱 **Open in browser:** https://github.com/DarrylClay2005/DarrylClay2005/settings/secrets/actions

**Add Secret 1:**
- Name: `WAKATIME_API_KEY`
- Value: Your API key from step 2

**Add Secret 2:**
- Name: `GH_TOKEN`  
- Value: GitHub Personal Access Token (create below)

### 5. Create GitHub Token
📱 **Open in browser:** https://github.com/settings/tokens
- Click "Generate new token (classic)"
- Name: "WakaTime Profile Stats"
- Expiration: No expiration (or 1 year)
- Select scopes:
  - ☑️ `repo` (Full control of private repositories)
  - ☑️ `workflow` (Update GitHub Action workflows)
- Click "Generate token"
- **Copy the token** and add as `GH_TOKEN` secret above

### 6. Test Setup
- **Start coding** in VS Code for a few minutes
- Check WakaTime dashboard: https://wakatime.com/dashboard
- Manually trigger GitHub Action: https://github.com/DarrylClay2005/DarrylClay2005/actions

## 📊 What You'll See

After 24 hours of coding, your profile will show:

```
📊 This Week I Spent My Time On:

💬 Programming Languages:
JavaScript   8 hrs 15 mins   ████████████████░░░░░   65.23%
Python       2 hrs 45 mins   ████████░░░░░░░░░░░░░   21.78%
HTML         1 hr 2 mins     ████░░░░░░░░░░░░░░░░░   8.19%

🔥 Editors:
VS Code      10 hrs 30 mins  ████████████████████░   83.22%

🐱‍💻 Projects:
animeverse-app    5 hrs 23 mins   ██████████████░░░░░░░   42.67%
portfolio         2 hrs 1 min     ████░░░░░░░░░░░░░░░░░   16.02%

💻 Operating System:
Linux        12 hrs 37 mins  ████████████████████░   100.0%
```

## 🕐 Timeline
- **Now**: Setup accounts and secrets
- **1 hour**: Start seeing data in WakaTime dashboard  
- **24 hours**: First stats appear in GitHub profile
- **1 week**: Full weekly statistics available

## 🆘 Need Help?
- Run: `./setup_wakatime.sh` for interactive setup
- Check: `WAKATIME_INTEGRATION.md` for detailed guide
- Troubleshoot: GitHub Actions tab for error messages

## 🎯 Quick Links
- **Your Profile**: https://github.com/DarrylClay2005
- **WakaTime Dashboard**: https://wakatime.com/dashboard
- **GitHub Actions**: https://github.com/DarrylClay2005/DarrylClay2005/actions
- **Repository Settings**: https://github.com/DarrylClay2005/DarrylClay2005/settings
