
@echo off
setlocal EnableExtensions
title Portable OpenClaude - Setup

:: ==========================================
:: Portable OpenClaude - Automatic Setup
:: Node.js 24.21.0 | Windows x64
:: ==========================================

set "ROOT=%~dp0"
set "NODE_DIR=%ROOT%node"
set "GLOBAL_DIR=%ROOT%npm-global"
set "CACHE_DIR=%ROOT%npm-cache"

set "NODE_VERSION=v24.21.0"
set "NODE_ZIP=node-v24.21.0-win-x64.zip"
set "NODE_URL=https://nodejs.org/dist/v24.21.0/%NODE_ZIP%"
set "NODE_SHA256=158f7685b44de51f6c0df1d153526cbcd3e1bc739a8dfc607721cef75de9e541"

echo.
echo ==========================================
echo       PORTABLE OPENCLAUDE SETUP
echo ==========================================
echo.

:: Check PowerShell availability
where powershell.exe >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Windows PowerShell was not found.
    pause
    exit /b 1
)

:: Download and extract Node.js if not installed
if not exist "%NODE_DIR%\node.exe" (
    echo [1/4] Downloading Node.js %NODE_VERSION%...

    set "NODE_URL=%NODE_URL%"
    set "NODE_ZIP=%NODE_ZIP%"
    set "NODE_DIR=%NODE_DIR%"
    set "NODE_SHA256=%NODE_SHA256%"

    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference='Stop'; try { " ^
    "$zip=Join-Path $env:TEMP $env:NODE_ZIP; " ^
    "$extract=Join-Path $env:TEMP 'PortableOpenClaudeExtract'; " ^
    "Write-Host 'Downloading official Node.js archive...'; " ^
    "Invoke-WebRequest -Uri $env:NODE_URL -OutFile $zip; " ^
    "$hash=(Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash.ToLower(); " ^
    "if ($hash -ne $env:NODE_SHA256) { throw 'SHA-256 verification failed. Archive rejected.' }; " ^
    "Write-Host 'Checksum verified.'; " ^
    "if (Test-Path $extract) { Remove-Item $extract -Recurse -Force }; " ^
    "Expand-Archive -LiteralPath $zip -DestinationPath $extract -Force; " ^
    "New-Item -ItemType Directory -Path $env:NODE_DIR -Force | Out-Null; " ^
    "Copy-Item -Path (Join-Path $extract 'node-v24.21.0-win-x64\*') -Destination $env:NODE_DIR -Recurse -Force; " ^
    "Remove-Item $zip -Force; Remove-Item $extract -Recurse -Force; " ^
    "Write-Host 'Node.js extracted successfully.'; " ^
    "} catch { Write-Host ('ERROR: ' + $_.Exception.Message); exit 1 }"

    if errorlevel 1 (
        echo.
        echo [ERROR] Node.js download or extraction failed.
        echo Check your internet connection and try again.
        pause
        exit /b 1
    )
) else (
    echo [1/4] Portable Node.js is already available.
)

:: Verify Node.js and npm
if not exist "%NODE_DIR%\node.exe" (
    echo [ERROR] node.exe is missing.
    pause
    exit /b 1
)

if not exist "%NODE_DIR%\npm.cmd" (
    echo [ERROR] npm.cmd is missing.
    pause
    exit /b 1
)

for /f "delims=" %%V in ('"%NODE_DIR%\node.exe" -v') do set "ACTUAL_VERSION=%%V"

echo [2/4] Detected Node.js: %ACTUAL_VERSION%

echo %ACTUAL_VERSION% | findstr /b /c:"v24." >nul
if errorlevel 1 (
    echo [ERROR] Node.js 24.x is required.
    echo Detected: %ACTUAL_VERSION%
    pause
    exit /b 1
)

:: Create local npm directories
if not exist "%GLOBAL_DIR%" mkdir "%GLOBAL_DIR%"
if not exist "%CACHE_DIR%" mkdir "%CACHE_DIR%"

:: Configure portable npm environment for this process
set "NPM_CONFIG_PREFIX=%GLOBAL_DIR%"
set "NPM_CONFIG_CACHE=%CACHE_DIR%"
set "PATH=%NODE_DIR%;%GLOBAL_DIR%;%PATH%"

echo.
echo Node.js version:
call "%NODE_DIR%\node.exe" -v
echo npm version:
call "%NODE_DIR%\npm.cmd" -v

:: Install OpenClaude
echo.
echo [3/4] Installing OpenClaude...
echo This may take several minutes.
echo.

call "%NODE_DIR%\npm.cmd" install -g @twigpine/openclaude@latest

if errorlevel 1 (
    echo.
    echo [ERROR] OpenClaude installation failed.
    echo Check the npm error above, then run setup again.
    pause
    exit /b 1
)

:: Verify launcher
if not exist "%GLOBAL_DIR%\openclaude.cmd" (
    echo.
    echo [ERROR] OpenClaude launcher was not found.
    echo Expected: "%GLOBAL_DIR%\openclaude.cmd"
    pause
    exit /b 1
)

echo.
echo [4/4] Setup completed successfully!
echo.
echo ==========================================
echo  Portable OpenClaude is ready.
echo.
echo  Run Launch-OpenClaude.bat to start it.
echo ==========================================
echo.
pause
exit /b 0
