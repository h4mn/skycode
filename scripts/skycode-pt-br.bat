@echo off
:: SkyCode pt-BR Launcher
:: Start VS Code with Brazilian Portuguese localization

setlocal

title SkyCode pt-BR 🇧🇷

pushd %~dp0\..
set ROOT_DIR=%CD%
set VSCODE_DIR=%ROOT_DIR%\vscode
set I18N_SCRIPT=%ROOT_DIR%\scripts\apply-i18n.js

echo Iniciando SkyCode com localização pt-BR...
echo.

:: Verificar se VS Code existe
if not exist "%VSCODE_DIR%" (
    echo ERRO: VS Code não encontrado em %VSCODE_DIR%
    pause
    exit /b 1
)

:: Mudar para diretório do VS Code
cd /d "%VSCODE_DIR%"

:: Verificar se está compilado
if not exist "out\main.js" (
    echo ERRO: VS Code não compilado
    echo Execute: npm run compile
    pause
    exit /b 1
)

:: Aplicar localização
echo Aplicando localização pt-BR...
node "%I18N_SCRIPT%"
if %errorlevel% neq 0 (
    echo ERRO: Falha na localização
    pause
    exit /b 1
)

echo Localização aplicada com sucesso!
echo.

:: Pre-launch script (como no code.bat oficial)
if "%VSCODE_SKIP_PRELAUNCH%"=="" (
	node build/lib/preLaunch.ts
)

:: Obter nome do executável do product.json
for /f "tokens=2 delims=:," %%a in ('findstr /R /C:"\"nameShort\":.*" product.json') do set NAMESHORT=%%~a
set NAMESHORT=%NAMESHORT: "=%
set NAMESHORT=%NAMESHORT:"=%.exe
set CODE=".build\electron\%NAMESHORT%"

:: Configuração de PRODUÇÃO (permite localização)
set NODE_ENV=production
rem set VSCODE_DEV=        :: DESABILITADO - permite localização
rem set VSCODE_CLI=        :: DESABILITADO - permite localização
set ELECTRON_ENABLE_LOGGING=0
set ELECTRON_ENABLE_STACK_DUMPING=0

:: Configuração de extensões para produção
set DISABLE_TEST_EXTENSION="--disable-extension=vscode.vscode-api-tests"
for %%A in (%*) do (
	if "%%~A"=="--extensionTestsPath" (
		set DISABLE_TEST_EXTENSION=""
	)
)

:: Iniciar com localização pt-BR
echo Iniciando SkyCode com locale pt-BR...
echo Executável: %CODE%
echo Parâmetros: . %DISABLE_TEST_EXTENSION% --locale=ptb %*
echo.
echo Aguarde a interface em português brasileiro! 🇧🇷
echo.

:: Launch Code com locale pt-BR (como no script oficial)
%CODE% . %DISABLE_TEST_EXTENSION% --locale=ptb %*

popd

echo.
echo > "Quando o código fala a sua língua, a programação flui naturalmente" - made by Sky 🇧🇷

endlocal