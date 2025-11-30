# Script para configurar o fork do VS Code (Windows PowerShell)
# Uso: .\setup-vscode-fork.ps1 seu-usuario-github

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUser
)

$vscodeDir = "..\vscode"

Write-Host "🚀 Configurando fork do VS Code para o usuário: $GitHubUser" -ForegroundColor Green
Write-Host "📁 Diretório: $vscodeDir" -ForegroundColor Yellow

# Verificar se já existe um repositório
if (Test-Path "$vscodeDir\.git") {
    Write-Host "⚠️  Já existe um repositório Git em $vscodeDir" -ForegroundColor Yellow
    $response = Read-Host "Deseja continuar e sobrescrever? (s/N)"
    if ($response -notmatch '^[Ss]$') {
        Write-Host "❌ Operação cancelada" -ForegroundColor Red
        exit 1
    }

    # Limpar diretório (cuidado!)
    Remove-Item -Path "$vscodeDir\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$vscodeDir\.*" -Recurse -Force -ErrorAction SilentlyContinue
}

Set-Location $vscodeDir

Write-Host "📥 Clonando seu fork..." -ForegroundColor Blue
git clone "https://github.com/$GitHubUser/vscode.git" .

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao clonar o repositório" -ForegroundColor Red
    exit 1
}

Write-Host "🔗 Adicionando upstream oficial..." -ForegroundColor Blue
git remote add upstream https://github.com/microsoft/vscode.git

Write-Host "📋 Configuração concluída!" -ForegroundColor Green
Write-Host ""
Write-Host "Próximos comandos:" -ForegroundColor Cyan
Write-Host "  cd vscode"
Write-Host "  yarn                    # Instalar dependências"
Write-Host "  yarn gulp compile       # Compilar VS Code"
Write-Host ""
Write-Host "Para sincronizar com upstream:" -ForegroundColor Cyan
Write-Host "  git fetch upstream"
Write-Host "  git merge upstream/main"

Write-Host ""
Write-Host "✅ Setup do fork VS Code concluído com sucesso!" -ForegroundColor Green