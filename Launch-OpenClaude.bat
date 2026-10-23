 @echo off
setlocal EnableExtensions
title Portable OpenClaude

:: ==========================================
:: Portable OpenClaude Launcher
:: Author: Nominda Yasasvin
:: ==========================================

cd /d "%~dp0"

set "ROOT=%~dp0"
set "NODE_DIR=%ROOT%node"
set "GLOBAL_DIR=%ROOT%npm-global"
set "CACHE_DIR=%ROOT%npm-cache"
set "OPENCLAUDE_CMD=%GLOBAL_DIR%\openclaude.cmd"

:: Check portable Node.js
if not exist "%NODE_DIR%\node.exe" (
    echo [ERROR] Portable Node.js is missing.
    echo Please run Setup-OpenClaude.bat first.
    pause
    exit /b 1
)

if not exist "%NODE_DIR%\npm.cmd" (
    echo [ERROR] npm.cmd is missing.
    echo Please run Setup-OpenClaude.bat again.
    pause
    exit /b 1
)

:: Check OpenClaude installation
if not exist "%OPENCLAUDE_CMD%" (
    echo [ERROR] OpenClaude is not installed.
    echo Please run Setup-OpenClaude.bat first.
    pause
    exit /b 1
)

:: Use project-local npm directories
if not exist "%GLOBAL_DIR%" mkdir "%GLOBAL_DIR%"
if not exist "%CACHE_DIR%" mkdir "%CACHE_DIR%"

set "NPM_CONFIG_PREFIX=%GLOBAL_DIR%"
set "NPM_CONFIG_CACHE=%CACHE_DIR%"
set "PATH=%NODE_DIR%;%GLOBAL_DIR%;%PATH%"

cls
echo =========================================
echo        PORTABLE OPENCLAUDE
echo =========================================
echo.
echo Node.js Version:
"%NODE_DIR%\node.exe" -v

echo npm Version:
call "%NODE_DIR%\npm.cmd" -v

echo.
echo Starting OpenClaude...
echo.

call "%OPENCLAUDE_CMD%"

set "EXIT_CODE=%ERRORLEVEL%"

echo.
echo OpenClaude has exited with code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%