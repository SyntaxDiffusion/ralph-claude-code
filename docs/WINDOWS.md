# Ralph for Claude Code - Windows Setup Guide

This guide explains how to install and run Ralph on Windows using Git Bash.

## Prerequisites

### 1. Git Bash (Required)

Ralph requires a Unix-like shell environment. On Windows, use **Git Bash** which comes with [Git for Windows](https://git-scm.com/download/win).

Download and install Git for Windows if you haven't already.

### 2. Node.js (Required)

Download and install Node.js from [nodejs.org](https://nodejs.org/).

After installation, verify in Git Bash:
```bash
node --version
npm --version
```

### 3. jq (Required)

jq is a JSON processor used by Ralph. Install using one of these methods:

**Option A: Using Chocolatey (recommended)**
```powershell
# Run in PowerShell as Administrator
choco install jq
```

**Option B: Manual Download**
1. Download `jq-win64.exe` from [jq releases](https://github.com/stedolan/jq/releases)
2. Rename it to `jq.exe`
3. Move to a directory in your PATH (e.g., `C:\Program Files\Git\usr\bin\`)

Verify in Git Bash:
```bash
jq --version
```

### 4. Claude Code CLI

The Claude Code CLI will be automatically downloaded when you first run Ralph. No manual installation needed.

## Installation

Open Git Bash and run:

```bash
# Clone the repository
git clone https://github.com/SyntaxDiffusion/ralph-claude-code.git
cd ralph-claude-code

# Run the installer
./install.sh
```

### Add to PATH

Add this line to your `~/.bashrc` file in Git Bash:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Then reload:
```bash
source ~/.bashrc
```

## Usage on Windows

### Creating a Project

```bash
ralph-setup my-project
cd my-project
```

### Running Ralph

On Windows, the `--monitor` flag works differently. Since tmux is not available, you'll need to use **two Git Bash windows**:

**Window 1 - Main Loop:**
```bash
cd my-project
ralph
```

**Window 2 - Monitor (optional):**
```bash
cd my-project
ralph-monitor
```

If you run `ralph --monitor` on Windows, it will ask if you want to continue without integrated monitoring and run the loop in the current window.

### Other Commands

```bash
# Show status
ralph --status

# Show circuit breaker status
ralph --circuit-status

# Reset circuit breaker
ralph --reset-circuit

# Import a PRD document
ralph-import my-prd.md my-project-name
```

## Windows-Specific Notes

### No tmux Support

tmux is not available on Git Bash. The integrated monitoring (`ralph --monitor`) that works on Linux/macOS by creating a split terminal view is not available on Windows.

**Alternative:** Use two Git Bash windows side by side.

### Path Handling

Ralph handles Windows paths automatically. Use forward slashes (`/`) in Git Bash:
```bash
# Good
cd /c/Users/YourName/projects/my-project

# Also works
cd ~/projects/my-project
```

### Line Endings

If you edit Ralph files on Windows, ensure you use Unix-style line endings (LF, not CRLF). Git Bash typically handles this, but if you edit with Windows tools:

```bash
# Configure git to handle line endings
git config --global core.autocrlf input
```

### Environment Variables

Set the `ANTHROPIC_API_KEY` environment variable:

**In Git Bash (temporary):**
```bash
export ANTHROPIC_API_KEY="your-api-key"
```

**In ~/.bashrc (permanent):**
```bash
echo 'export ANTHROPIC_API_KEY="your-api-key"' >> ~/.bashrc
source ~/.bashrc
```

**In Windows System Environment Variables (permanent):**
1. Press Win + X, select "System"
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Add a new User variable: `ANTHROPIC_API_KEY` with your key

## Troubleshooting

### "command not found: ralph"

Your PATH is not set correctly. Add `~/.local/bin` to your PATH:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### "jq: command not found"

Install jq using the instructions above, or verify it's in your PATH:
```bash
which jq
```

### Slow execution

Git Bash can be slower than native Linux. This is normal. For better performance:
- Close unnecessary applications
- Use Windows Terminal instead of the default Git Bash window
- Consider using WSL2 for better performance (see below)

### Permission errors

If you see permission errors, try:
```bash
chmod +x ~/.local/bin/ralph
chmod +x ~/.local/bin/ralph-monitor
chmod +x ~/.local/bin/ralph-setup
```

## Alternative: WSL2 (Recommended for Power Users)

For the best experience on Windows, consider using **Windows Subsystem for Linux 2 (WSL2)**:

1. Enable WSL2 in Windows
2. Install Ubuntu from the Microsoft Store
3. Install Ralph in the WSL2 Ubuntu environment
4. Full tmux support available

```bash
# In WSL2 Ubuntu
sudo apt update
sudo apt install nodejs npm jq tmux git

# Then follow Linux installation instructions
```

WSL2 provides:
- Full tmux support for integrated monitoring
- Better file system performance
- Native Linux behavior

## Getting Help

- Check `ralph --help` for all options
- View logs in `logs/ralph.log`
- Check circuit breaker status: `ralph --circuit-status`
- Report issues: https://github.com/SyntaxDiffusion/ralph-claude-code/issues
