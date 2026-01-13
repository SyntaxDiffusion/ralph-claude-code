@echo off
REM Ralph for Claude Code - Windows Installer
REM Run this from Windows CMD or PowerShell to install Ralph

setlocal enabledelayedexpansion
title Ralph for Claude Code - Windows Installer

echo.
echo  ========================================
echo    Ralph for Claude Code - Windows Setup
echo  ========================================
echo.

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
    echo [ERROR] Git Bash not found!
    echo.
    echo Please install Git for Windows:
    echo   https://git-scm.com/download/win
    echo.
    echo After installation, run this installer again.
    pause
    exit /b 1
)

echo [OK] Git Bash found: %GITBASH%

REM Check for Node.js
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js not found!
    echo.
    echo Please install Node.js:
    echo   https://nodejs.org/
    echo.
    pause
    exit /b 1
)
echo [OK] Node.js found

REM Check for jq (optional but recommended)
where jq >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [WARN] jq not found - Ralph requires jq for JSON processing
    echo.
    echo Install jq using one of these methods:
    echo   1. Chocolatey: choco install jq
    echo   2. Download from: https://github.com/stedolan/jq/releases
    echo      Put jq.exe in: C:\Program Files\Git\usr\bin\
    echo.
    set /p CONTINUE="Continue anyway? (y/n): "
    if /i not "!CONTINUE!"=="y" (
        exit /b 1
    )
) else (
    echo [OK] jq found
)

echo.
echo Running bash installer...
echo.

REM Get the directory where this batch file is located
set "RALPH_DIR=%~dp0"
set "RALPH_DIR_UNIX=%RALPH_DIR:\=/%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:C:=/c%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:D:=/d%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:E:=/e%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:F:=/f%"
set "RALPH_DIR_UNIX=%RALPH_DIR_UNIX:G:=/g%"

REM Run the bash installer
"%GITBASH%" -c "cd '%RALPH_DIR_UNIX%' && ./install.sh"

echo.
echo  ========================================
echo    Windows Batch Launchers
echo  ========================================
echo.
echo The following .bat files are available in:
echo   %RALPH_DIR%
echo.
echo   ralph.bat         - Run Ralph loop (auto-uses inline monitor)
echo   ralph-monitor.bat - Run the monitor dashboard
echo.

REM Ask about adding to PATH
echo To use ralph from any directory, you can:
echo   1. Add "%RALPH_DIR%" to your Windows PATH
echo   2. Or copy the .bat files to a folder in your PATH
echo.

set /p ADDPATH="Add Ralph to Windows PATH? (y/n): "
if /i "%ADDPATH%"=="y" (
    echo.
    echo Adding to User PATH...

    REM Add to user PATH using setx
    for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USERPATH=%%b"

    if defined USERPATH (
        echo !USERPATH! | findstr /i "%RALPH_DIR:~0,-1%" >nul
        if !ERRORLEVEL! NEQ 0 (
            setx PATH "!USERPATH!;%RALPH_DIR:~0,-1%" >nul 2>&1
            echo [OK] Added to PATH. Restart your terminal to use 'ralph' globally.
        ) else (
            echo [OK] Already in PATH.
        )
    ) else (
        setx PATH "%RALPH_DIR:~0,-1%" >nul 2>&1
        echo [OK] Added to PATH. Restart your terminal to use 'ralph' globally.
    )
)

echo.
echo  ========================================
echo    Installation Complete!
echo  ========================================
echo.
echo Quick Start:
echo   1. Open a new CMD or PowerShell window
echo   2. Navigate to a Ralph project: cd your-project
echo   3. Run: ralph --inline-monitor
echo.
echo Or create a new project:
echo   "%GITBASH%" -c "ralph-setup my-project"
echo.
pause
endlocal
