@echo off
:: SkyCode Development Launcher
:: Start VS Code with pt-BR internationalization

setlocal enabledelayedexpansion

title SkyCode Dev (pt-BR)

chcp 65001 >nul

echo Starting SkyCode in development mode with pt-BR internationalization...
echo.

:: Configure directories
pushd %~dp0\..
set ROOT_DIR=%CD%
set VSCODE_DIR=%ROOT_DIR%\vscode
set I18N_SCRIPT=%ROOT_DIR%\scripts\apply-i18n.js

echo Root directory: %ROOT_DIR%
echo VS Code: %VSCODE_DIR%
echo i18n script: %I18N_SCRIPT%
echo.

:: Check if VS Code fork exists
if not exist "%VSCODE_DIR%" (
    echo ERROR: VS Code fork not found at: %VSCODE_DIR%
    echo Run initial setup first.
    pause
    exit /b 1
)

:: Change to VS Code directory
cd /d "%VSCODE_DIR%"

:: Check if node modules exists
if not exist "node_modules" (
    echo Installing VS Code dependencies...
    npm install
    if !errorlevel! neq 0 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)

:: Apply internationalization
echo Applying pt-BR internationalization...
node "%I18N_SCRIPT%"
if !errorlevel! neq 0 (
    echo ERROR: Failed to apply internationalization
    pause
    exit /b 1
)

:: Check if VS Code is already compiled
if not exist "out\main.js" (
    echo Compiling VS Code (first run may take a while)...
    npm run compile
    if !errorlevel! neq 0 (
        echo ERROR: Compilation failed
        pause
        exit /b 1
    )
    echo VS Code compiled successfully!
) else (
    echo VS Code already compiled
)

:: Start VS Code with locale pt-BR
echo.
echo Starting VS Code with locale pt-BR...
echo Tips:
echo    - Configure "locale": "ptb" in settings.json for persistence
echo    - Use --locale=ptb in future runs
echo    - Interface should appear in Brazilian Portuguese
echo.

:: Development environment variables
set NODE_ENV=development
set VSCODE_DEV=1
set VSCODE_CLI=1
set ELECTRON_ENABLE_LOGGING=1
set ELECTRON_ENABLE_STACK_DUMPING=1

:: Start with locale pt-BR
node .\build\lib\electron.js . --locale=ptb %*

popd

echo.
echo > "Development comes to life when we speak the user's language" - made by Sky

endlocal