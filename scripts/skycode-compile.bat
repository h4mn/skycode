@echo off
:: SkyCode Compile Script
:: Compile VS Code with internationalization support

setlocal

chcp 65001 >nul

echo Compiling SkyCode with pt-BR internationalization...
echo.

pushd %~dp0\..
set ROOT_DIR=%CD%
set VSCODE_DIR=%ROOT_DIR%\vscode
set I18N_SCRIPT=%ROOT_DIR%\scripts\apply-i18n.js

cd /d "%VSCODE_DIR%"

:: Check dependencies
if not exist "node_modules" (
    echo Installing dependencies...
    npm install
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)

:: Apply internationalization
echo Applying internationalization...
node "%I18N_SCRIPT%"
if errorlevel 1 (
    echo ERROR: Failed to apply internationalization
    pause
    exit /b 1
)

:: Compile
echo Compiling VS Code...
npm run compile
if errorlevel 1 (
    echo ERROR: Compilation failed
    pause
    exit /b 1
)

echo SkyCode compiled successfully!
echo Use scripts\skycode-dev.bat to start

echo.
echo > "Every compilation is a step toward perfection" - made by Sky

popd

endlocal