@echo off
echo 🚀 Configurando MCP GitHub para Claude Code...
echo.

REM Obter o PATH do GitHub CLI
for /f "tokens=1,2*" %%a in ('gh auth token') do (
    if "!first!"=="" set "gh_output=%%a"
    set "first="
)

if "%gh_output%"=="" (
    echo ❌ Nenhum token encontrado via GitHub CLI
    echo.
    echo Por favor, configure seu GitHub CLI com:
    echo gh auth login
    echo.
    pause
    exit /b 1
)

echo ✅ Token GitHub encontrado via CLI
echo.

REM Configurar o arquivo MCP
set MCP_FILE=%USERPROFILE%\.claude\mcp.json
set MCP_BACKUP=%USERPROFILE%\.claude\mcp.json.backup

REM Fazer backup se o arquivo existir
if exist "%MCP_FILE%" (
    echo 💾 Fazendo backup do arquivo MCP existente...
    copy "%MCP_FILE%" "%MCP_BACKUP%" >nul 2>&1
)

echo 🔧 Adicionando configuração GitHub ao MCP...

REM Verificar se o arquivo MCP existe e se já tem a chave mcpServers
if not exist "%MCP_FILE%" (
    echo {"mcpServers": {}} > "%MCP_FILE%"
    set MCP_EXISTS=0
) else (
    set MCP_EXISTS=1
)

REM Remover configuração anterior do GitHub se existir
powershell -Command "(Get-Content '%MCP_FILE%' -Raw) -replace '(\s*\"github\"[^}]*\}?\s*){','' -replace ',,' ',' | Set-Content '%MCP_FILE%'"

REM Adicionar nova configuração do GitHub
(
echo.
echo   "github": {
echo     "command": "npx",
echo     "args": ["-y", "@modelcontextprotocol/server-github"],
echo     "env": {
echo       "GITHUB_PERSONAL_ACCESS_TOKEN": ""
echo     },
echo     "alwaysAllow": [
echo       "github_create_or_update_file",
echo       "github_create_pull_request",
echo       "github_create_issue",
echo       "github_get_repo",
echo       "github_get_repo_file_content",
echo       "github_list_commits",
echo       "github_list_branches",
echo       "github_list_pull_requests",
echo       "github_list_issues",
echo       "github_search_issues",
echo       "github_search_repositories",
echo       "github_create_repository",
echo       "github_star_repository",
echo       "github_list_repo_files",
echo       "github_get_file_content",
echo       "github_create_or_update_pull_request",
echo       "github_create_or_update_branch",
echo       "github_get_pull_request",
echo       "github_create_issue_comment"
echo     ]
echo   }
echo.
) >> "%MCP_FILE%"

REM Remover vírgula extra se existir
powershell -Command "(Get-Content '%MCP_FILE%' -Raw) -replace ',\s*$' '' | Set-Content '%MCP_FILE%'"

echo ✅ MCP GitHub configurado com sucesso!
echo.
echo 📁 Arquivo: %MCP_FILE%
echo 💾 Backup: %MCP_BACKUP%
echo.
echo 🔄 Reinicie o Claude Code para carregar o MCP GitHub
echo.
echo 🌐 Para testar, tente usar comandos GitHub no Claude Code
echo.

pause