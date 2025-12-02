@echo off
:: SkyCode Run Script
:: Start compiled SkyCode with locale pt-BR

setlocal

title SkyCode Dev (pt-BR)

chcp 65001 >nul

echo Starting SkyCode with pt-BR internationalization...
echo.

pushd %~dp0\..
set VSCODE_DIR=%CD%\vscode

cd /d "%VSCODE_DIR%"

:: Check if already compiled
if not exist "out\main.js" (
    echo ERROR: SkyCode not compiled!
    echo Run scripts\skycode-compile.bat first
    pause
    exit /b 1
)

:: Check if internationalization was applied
if not exist "i18n\ptb\main.i18n.json" (
    echo ERROR: Internationalization not applied!
    echo Run scripts\skycode-dev.bat or scripts\skycode-compile.bat
    pause
    exit /b 1
)

echo Starting SkyCode...
echo Locale: pt-BR (Brazilian Portuguese)
echo.

:: Environment variables
set NODE_ENV=development
set VSCODE_DEV=1
set VSCODE_CLI=1
set ELECTRON_ENABLE_LOGGING=1
set ELECTRON_ENABLE_STACK_DUMPING=1

:: Start with locale pt-BR
node .\build\lib\electron.js . --locale=ptb %*

popd

echo.
echo > "Code with Brazilian flavor!" - made by Sky

endlocal