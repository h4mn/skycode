#!/bin/bash

# Script para configurar o fork do VS Code
# Uso: ./setup-vscode-fork.sh seu-usuario-github

if [ $# -eq 0 ]; then
    echo "❌ Erro: Informe seu usuário do GitHub"
    echo "Uso: $0 seu-usuario-github"
    exit 1
fi

GITHUB_USER=$1
VSCODE_DIR="../vscode"

echo "🚀 Configurando fork do VS Code para o usuário: $GITHUB_USER"
echo "📁 Diretório: $VSCODE_DIR"

# Verificar se já existe um repositório
if [ -d "$VSCODE_DIR/.git" ]; then
    echo "⚠️  Já existe um repositório Git em $VSCODE_DIR"
    read -p "Deseja continuar e sobrescrever? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "❌ Operação cancelada"
        exit 1
    fi
    rm -rf "$VSCODE_DIR/.*" "$VSCODE_DIR/*" 2>/dev/null
fi

cd "$VSCODE_DIR"

echo "📥 Clonando seu fork..."
git clone "https://github.com/$GITHUB_USER/vscode.git" .

if [ $? -ne 0 ]; then
    echo "❌ Erro ao clonar o repositório"
    exit 1
fi

echo "🔗 Adicionando upstream oficial..."
git remote add upstream https://github.com/microsoft/vscode.git

echo "📋 Configuração concluída!"
echo ""
echo "Próximos comandos:"
echo "  cd vscode"
echo "  yarn                    # Instalar dependências"
echo "  yarn gulp compile       # Compilar VS Code"
echo ""
echo "Para sincronizar com upstream:"
echo "  git fetch upstream"
echo "  git merge upstream/main"

echo ""
echo "✅ Setup do fork VS Code concluído com sucesso!"