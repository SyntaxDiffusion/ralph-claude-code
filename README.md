# Ralph for Claude Code

[![CI](https://github.com/SyntaxDiffusion/ralph-claude-code/actions/workflows/test.yml/badge.svg)](https://github.com/SyntaxDiffusion/ralph-claude-code/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Version](https://img.shields.io/badge/version-0.9.9-blue)
![Tests](https://img.shields.io/badge/tests-276%20passing-green)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey)

> **Autonomous AI development loop with intelligent exit detection and rate limiting**

Ralph enables continuous autonomous development cycles where Claude Code iteratively improves your project until completion. Named after [Ralph Wiggum](https://ghuntley.com/ralph/) from Geoffrey Huntley's technique.

**Works on Windows, macOS, and Linux** - Install once, use everywhere.

---

## Quick Start

### Windows (CMD/PowerShell)

```cmd
git clone https://github.com/SyntaxDiffusion/ralph-claude-code.git
cd ralph-claude-code
install-windows.bat
```

Then in any project directory:
```cmd
ralph --inline-monitor
```

### macOS/Linux

```bash
git clone https://github.com/SyntaxDiffusion/ralph-claude-code.git
cd ralph-claude-code
./install.sh
```

Then in any project directory:
```bash
ralph --monitor
```

---

## Windows Installation

### Prerequisites

1. **Git for Windows** - [Download](https://git-scm.com/download/win) (includes Git Bash)
2. **Node.js** - [Download](https://nodejs.org/)
3. **jq** - `choco install jq` or [download](https://github.com/stedolan/jq/releases)

### Install

```cmd
:: Clone the repo
git clone https://github.com/SyntaxDiffusion/ralph-claude-code.git
cd ralph-claude-code

:: Run Windows installer
install-windows.bat
```

The installer will:
- Check for Git Bash, Node.js, and jq
- Install Ralph globally
- Optionally add to your Windows PATH

### Usage on Windows

```cmd
:: Create a new project
ralph-setup my-project
cd my-project

:: Run with inline monitor (recommended)
ralph --inline-monitor

:: Or just ralph (defaults to inline monitor on Windows)
ralph --monitor
```

**Inline Monitor** shows real-time status in your terminal:
```
╔══════════════════════════════════════════════════════════════════════════╗
║                     🤖 RALPH - Inline Monitor Mode                       ║
╚══════════════════════════════════════════════════════════════════════════╝

[14:32:15] Loop #3   │ ⠙ executing │ Calls: 5/100 │ Tasks: 7 │ CB: CLOSED
✅ Loop #3 completed (45s, 3 files changed)
```

### Windows Batch Files

| Command | Description |
|---------|-------------|
| `ralph.bat` | Run Ralph loop (auto-uses inline monitor) |
| `ralph-monitor.bat` | Run monitor dashboard |
| `ralph-setup.bat` | Create new project |
| `install-windows.bat` | Install Ralph |

---

## macOS/Linux Installation

### Prerequisites

```bash
# macOS
brew install node jq tmux git

# Ubuntu/Debian
sudo apt-get install nodejs npm jq tmux git

# CentOS/RHEL
sudo yum install nodejs npm jq tmux git
```

### Install

```bash
git clone https://github.com/SyntaxDiffusion/ralph-claude-code.git
cd ralph-claude-code
./install.sh
```

### Usage

```bash
# Create a new project
ralph-setup my-project
cd my-project

# Run with tmux split-pane monitoring
ralph --monitor

# Or run loop and monitor separately
ralph              # Terminal 1
ralph-monitor      # Terminal 2
```

---

## How It Works

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   PROMPT.md     │────▶│   Claude Code    │────▶│  Your Project   │
│   @fix_plan.md  │     │   (Autonomous)   │     │  (Improved)     │
└─────────────────┘     └──────────────────┘     └─────────────────┘
        ▲                        │                        │
        └────────────────────────┴────────────────────────┘
                         Loop until complete
```

1. **Read** - Loads `PROMPT.md` with your project requirements
2. **Execute** - Runs Claude Code with current context
3. **Track** - Updates task lists and logs results
4. **Evaluate** - Checks for completion signals
5. **Repeat** - Continues until project is complete

### Intelligent Exit Detection

Ralph automatically stops when:
- All tasks in `@fix_plan.md` marked complete
- Multiple "done" signals from Claude Code
- Too many test-only loops (feature completeness)
- Circuit breaker detects stagnation

---

## Project Structure

```
my-project/
├── PROMPT.md           # Instructions for Ralph
├── @fix_plan.md        # Prioritized task list
├── @AGENT.md           # Build/run instructions
├── specs/              # Specifications
├── src/                # Source code
├── logs/               # Execution logs
└── docs/generated/     # Auto-generated docs
```

---

## Command Reference

### Core Commands

```bash
ralph                    # Start loop (inline monitor on Windows)
ralph --monitor          # Start with monitoring
ralph --inline-monitor   # Force inline monitor mode
ralph --status           # Show current status
ralph --help             # Show all options
```

### Configuration

```bash
ralph --calls 50         # Limit to 50 calls/hour (default: 100)
ralph --timeout 30       # 30-minute timeout (default: 15)
ralph --verbose          # Detailed progress output
ralph --prompt FILE      # Custom prompt file
```

### Circuit Breaker

```bash
ralph --circuit-status   # Show circuit breaker state
ralph --reset-circuit    # Reset circuit breaker
ralph --reset-session    # Reset session state
```

### Project Setup

```bash
ralph-setup my-project              # Create new project
ralph-import requirements.md app    # Import PRD to project
```

---

## Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `--calls` | 100 | Max API calls per hour |
| `--timeout` | 15 | Execution timeout (minutes) |
| `--monitor` | off | Enable monitoring |
| `--inline-monitor` | off | Inline status bar |
| `--verbose` | off | Detailed progress |
| `--output-format` | json | Output format (json/text) |
| `--no-continue` | off | Disable session continuity |

---

## Roadmap

### Current: v0.9.9 ✅

- [x] Core autonomous loop with intelligent exit detection
- [x] Rate limiting (100 calls/hour, configurable)
- [x] Circuit breaker with stagnation detection
- [x] Session continuity across loops
- [x] JSON output format support
- [x] **Windows support with batch file launchers**
- [x] **Inline monitor mode for Windows**
- [x] tmux integration for macOS/Linux
- [x] PRD import functionality
- [x] 276 passing tests (100% pass rate)
- [x] CI/CD with GitHub Actions

### v1.0.0 - Stable Release 🎯

- [ ] Log rotation (prevent disk fill)
- [ ] Dry-run mode (preview without execution)
- [ ] Configuration file support (.ralphrc)
- [ ] Improved error messages
- [ ] Documentation site

### v1.1.0 - Enhanced Features

- [ ] Metrics and analytics dashboard
- [ ] Desktop notifications (Windows toast, macOS alerts)
- [ ] Git backup and rollback system
- [ ] Multiple project profiles
- [ ] Plugin system for custom analyzers

### v1.2.0 - Enterprise Features

- [ ] Team collaboration features
- [ ] Centralized logging
- [ ] API for external integrations
- [ ] Docker containerization
- [ ] Cloud deployment options

---

## Troubleshooting

### Windows

**"ralph is not recognized"**
- Run from the ralph-claude-code directory, or
- Run `install-windows.bat` and add to PATH

**"Git Bash not found"**
- Install [Git for Windows](https://git-scm.com/download/win)

**"jq not found"**
- Run `choco install jq` or download from [jq releases](https://github.com/stedolan/jq/releases)

### All Platforms

**"PROMPT.md not found"**
- Run from a Ralph project directory
- Create a project: `ralph-setup my-project`

**Ralph exits immediately**
- Reset state: `ralph --reset-circuit`
- Check `.exit_signals` file and clear it

**Circuit breaker opens**
- Check logs: `cat logs/ralph.log`
- Reset: `ralph --reset-circuit`

---

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/ralph-claude-code.git
cd ralph-claude-code

# Run tests (all 276 must pass)
npm test
```

Priority areas:
1. **Windows testing** - Test on different Windows versions
2. **Documentation** - Tutorials and examples
3. **Bug reports** - Real-world usage feedback

---

## License

MIT License - see [LICENSE](LICENSE)

## Acknowledgments

- [Ralph technique](https://ghuntley.com/ralph/) by Geoffrey Huntley
- [Claude Code](https://claude.ai/code) by Anthropic

---

**Ready to let AI build your project?**

```cmd
ralph-setup my-awesome-project && cd my-awesome-project && ralph --inline-monitor
```
