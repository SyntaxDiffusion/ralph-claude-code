@echo off
REM Ralph Monitor - Windows Launcher
REM This batch file launches ralph-monitor in Git Bash from Windows CMD/PowerShell

setlocal enabledelayedexpansion

REM Find Git Bash
set "GITBASH="
if exist "C:\Program Files\Git\bin\bash.exe" (
    set "GITBASH=C:\Program Files\Git\bin\bash.exe"
) else if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    set "GITBASH=C:\Program Files (x86)\Git\bin\bash.exe"
) else if exist "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" (
    set "GITBASH=%LOCALAPPDATA%\Programs\Git\bin\bash.exe"
) else (
    for /f "tokens=*" %%i in ('where git 2^>nul') do (
        set "GITPATH=%%~dpi"
        if exist "!GITPATH!..\bin\bash.exe" (
            set "GITBASH=!GITPATH!..\bin\bash.exe"
        )
    )
)

if "%GITBASH%"=="" (
    echo ERROR: Git Bash not found!
    echo Please install Git for Windows from https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Get the directory where this batch file is located
set "RALPH_DIR=%~dp0"

REM Convert Windows path to Unix path for Git Bash
set "RALPH_DIR_UNIX=%RALPH_DIR:\=/%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:C:=/c%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:D:=/d%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:E:=/e%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:F:=/f%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:G:=/g%"

REM Run ralph-monitor in Git Bash
echo Starting Ralph Monitor in Git Bash...
"%GITBASH%" -c "cd '%RALPH_DIR_UNIX%' && source ~/.bashrc 2>/dev/null; export PATH=\"$HOME/.local/bin:$PATH\"; if command -v ralph-monitor &>/dev/null; then ralph-monitor; else ./ralph_monitor.sh; fi"

endlocal
