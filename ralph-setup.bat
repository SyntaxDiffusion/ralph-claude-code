@echo off
REM Ralph Setup - Windows Launcher
REM Creates a new Ralph project

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

REM Get project name from argument or prompt
set "PROJECT_NAME=%~1"
if "%PROJECT_NAME%"=="" (
    set /p PROJECT_NAME="Enter project name: "
)

if "%PROJECT_NAME%"=="" (
    echo ERROR: Project name is required
    echo Usage: ralph-setup.bat project-name
    pause
    exit /b 1
)

echo Creating Ralph project: %PROJECT_NAME%
"%GITBASH%" -c "source ~/.bashrc 2>/dev/null; export PATH=\"$HOME/.local/bin:$PATH\"; if command -v ralph-setup &>/dev/null; then ralph-setup '%PROJECT_NAME%'; else echo 'Please run install-windows.bat first'; fi"

echo.
echo Next steps:
echo   cd %PROJECT_NAME%
echo   ralph --inline-monitor
echo.
pause
endlocal
