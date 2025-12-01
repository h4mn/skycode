# SkyCode MCP GitHub Setup Script
# Configura o MCP GitHub para Claude Code automaticamente

Write-Host "🚀 Configurando MCP GitHub para Claude Code..." -ForegroundColor Cyan
Write-Host ""

# Verificar se GitHub CLI está instalado
try {
    $ghVersion = gh --version
    Write-Host "✅ GitHub CLI encontrado: $ghVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ GitHub CLI não encontrado" -ForegroundColor Red
    Write-Host "Por favor, instale com: winget install GitHub.cli" -ForegroundColor Yellow
    exit 1
}

# Obter token do GitHub CLI
try {
    Write-Host "🔑 Obtendo token do GitHub CLI..." -ForegroundColor Yellow
    $ghOutput = gh auth token
    if (-not $ghOutput) {
        throw "Nenhum token encontrado"
    }
    Write-Host "✅ Token GitHub obtido com sucesso" -ForegroundColor Green
} catch {
    Write-Host "❌ Erro ao obter token GitHub: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Execute: gh auth login" -ForegroundColor Yellow
    exit 1
}

# Configurar caminhos
$mcpPath = "$env:USERPROFILE\.claude"
$mcpFile = "$mcpPath\mcp.json"
$mcpBackup = "$mcpPath\mcp.json.backup"

# Criar diretório se não existir
if (-not (Test-Path $mcpPath)) {
    New-Item -ItemType Directory -Path $mcpPath -Force
    Write-Host "📁 Criado diretório: $mcpPath" -ForegroundColor Blue
}

# Fazer backup se o arquivo existir
if (Test-Path $mcpFile) {
    Write-Host "💾 Fazendo backup do arquivo MCP existente..." -ForegroundColor Yellow
    Copy-Item $mcpFile $mcpBackup -Force
}

Write-Host "🔧 Configurando MCP GitHub..." -ForegroundColor Yellow

# Ler arquivo MCP existente ou criar nova estrutura
if (Test-Path $mcpFile) {
    try {
        $mcpConfig = Get-Content $mcpFile -Raw | ConvertFrom-Json
    } catch {
        $mcpConfig = @{ mcpServers = @{} }
    }
} else {
    $mcpConfig = @{ mcpServers = @{} }
}

# Remover configuração anterior do GitHub se existir
if ($mcpConfig.mcpServers.PSObject.Properties.Name -contains "github") {
    Write-Host "🗑️ Removendo configuração anterior do GitHub..." -ForegroundColor Yellow
    $mcpConfig.mcpServers.PSObject.Properties.Remove("github")
}

# Adicionar nova configuração do GitHub
$githubConfig = @{
    command = "npx"
    args = @("-y", "@modelcontextprotocol/server-github")
    env = @{
        GITHUB_PERSONAL_ACCESS_TOKEN = ""
    }
    alwaysAllow = @(
        "github_create_or_update_file",
        "github_create_pull_request",
        "github_create_issue",
        "github_get_repo",
        "github_get_repo_file_content",
        "github_list_commits",
        "github_list_branches",
        "github_list_pull_requests",
        "github_list_issues",
        "github_search_issues",
        "github_search_repositories",
        "github_create_repository",
        "github_star_repository",
        "github_list_repo_files",
        "github_get_file_content",
        "github_create_or_update_pull_request",
        "github_create_or_update_branch",
        "github_get_pull_request",
        "github_create_issue_comment"
    )
}

$mcpConfig.mcpServers | Add-Member -NotePropertyName github -NotePropertyValue $githubConfig -Force

# Salvar arquivo MCP
$mcpJson = $mcpConfig | ConvertTo-Json -Depth 10
Set-Content -Path $mcpFile -Value $mcpJson -Encoding UTF8

Write-Host "✅ MCP GitHub configurado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "📁 Arquivo: $mcpFile" -ForegroundColor Blue
Write-Host "💾 Backup: $mcpBackup" -ForegroundColor Blue
Write-Host ""
Write-Host "🔄 Reinicie o Claude Code para carregar o MCP GitHub" -ForegroundColor Yellow
Write-Host "🌐 Para testar, tente usar comandos GitHub no Claude Code" -ForegroundColor Cyan

# Criar atalho no desktop
$desktopPath = "$env:USERPROFILE\Desktop"
$shortcutPath = "$desktopPath\SkyCode MCP GitHub.url"
$shortcutContent = "[InternetShortcut]`r`nURL=claudedisabled://restart`r`nIconFile=C:\Program Files\Claude\claude.exe"

Set-Content -Path $shortcutPath -Value $shortcutContent -Encoding ASCII

Write-Host "🎯 Atalho criado na área de trabalho para reiniciar Claude" -ForegroundColor Green
Write-Host ""
Write-Host "Pressione qualquer tecla para sair..." -ForegroundColor White
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")