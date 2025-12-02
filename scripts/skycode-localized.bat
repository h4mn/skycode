@echo off
:: SkyCode Localized Launcher
:: Start VS Code with pt-BR internationalization (production mode)

setlocal

title SkyCode (pt-BR)

chcp 65001 >nul

echo Starting SkyCode with pt-BR internationalization...
echo.

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

:: Check if VS Code is compiled
if not exist "out\main.js" (
    echo ERROR: VS Code not compiled!
    echo Run scripts\skycode-compile.bat first
    pause
    exit /b 1
)

:: Apply internationalization
echo Applying pt-BR internationalization...
node "%I18N_SCRIPT%"
if %errorlevel% neq 0 (
    echo ERROR: Failed to apply internationalization
    pause
    exit /b 1
)

:: Start VS Code with locale pt-BR (PRODUCTION MODE for localization)
echo.
echo Starting VS Code with locale pt-BR...
echo Mode: PRODUCTION (localization enabled)
echo.
echo Tips:
echo    - Interface should appear in Brazilian Portuguese
echo    - Menus: File=Arquivo, Edit=Editar, View=Exibir, etc.
echo    - If still in English, check File ^> Preferences ^> Language
echo.

:: Production environment variables (localization enabled)
set NODE_ENV=production
rem set VSCODE_DEV=        :: DISABLED - allows localization
rem set VSCODE_CLI=        :: DISABLED - allows localization
set ELECTRON_ENABLE_LOGGING=0
set ELECTRON_ENABLE_STACK_DUMPING=0

:: Start with locale pt-BR
echo Locale: pt-BR (Brazilian Portuguese)
node .\build\lib\electron.ts . --locale=ptb %*

popd

echo.
echo "A interface fala a língua do desenvolvedor" - made by Sky 🇧🇷

endlocal