# Memory 003: SkyCode Shell e Branding Strategy

**Data**: 30/11/2025
**Projeto**: SkyCode - Branding e Scripts de Automação
**Status**: 📋 Arquitetura Definida

---

## 🎯 O que é SkyCode Shell?

**Definição**: Camada de automação e branding que separa customizações do VS Code original, mantendo o fork limpo e facilitando a distribuição.

### Propósito Principal
- **Separação de responsabilidades**: Branding ↔ Core VS Code
- **Automação**: Scripts de build, install e deploy
- **Distribuição**: Empacotar SkyCode como produto independente
- **Identidade Visual**: Logos, ícones, temas customizados

---

## 🏗️ Estrutura Completa de SkyCode Shell

```
skycode-shell/
├── README.md                       ← Documentação geral ✅
├── scripts/                        ← Scripts de automação ✅
│   ├── setup-vscode-fork.sh        ← Setup inicial do fork ✅
│   ├── setup-vscode-fork.ps1       ← Versão Windows 🔄
│   ├── build-skycode.sh            ← Build do produto completo
│   ├── package-skycode.sh           ← Empacotamento para distribuição
│   ├── install-skycode.sh          ← Script de instalação
│   └── sync-upstream.sh            ← Sync com VS Code oficial
├── branding/                       ← Identidade visual 🎨
│   ├── logos/                      ← Logotipos e ícones
│   │   ├── logo.svg                ← Logo principal
│   │   ├── icon-256.png            ← Ícone app (256x256)
│   │   ├── icon-512.png            ← Ícone app (512x512)
│   │   ├── splash.png              ← Tela inicial
│   │   └── favicon.ico             ← Favicon web
│   ├── themes/                     ← Temas customizados
│   │   ├── skycode-dark.json       ← Tema escuro SkyCode
│   │   ├── skycode-light.json      ← Tema claro SkyCode
│   │   └── skycode-adaptive.json  ← Tema adaptativo
│   ├── colors/                     ← Paleta de cores
│   │   ├── primary.json            ← Cores principais
│   │   ├── secondary.json          ← Cores secundárias
│   │   └── accent.json            ← Cores de destaque
│   └── fonts/                     ← Tipografia customizada
│       ├── skycode-mono.ttf        ← Fonte monoespaçada
│       └── skycode-ui.ttf          ← Fonte interface
├── installers/                     ← Scripts de instalação 📦
│   ├── windows/                    ← Instalador Windows
│   │   ├── installer.nsi           ← Script NSIS
│   │   └── setup.exe              ← Executável gerado
│   ├── linux/                      ← Instalador Linux
│   │   ├── build-deb.sh           ← Pacote .DEB
│   │   └── build-rpm.sh           ← Pacote .RPM
│   └── macos/                      ← Instalador macOS
│       ├── create-dmg.sh           ├── Pacote .DMG
│       └── SkyCode.app             ← App bundle
├── utils/                          ← Utilidades diversas 🛠️
│   ├── build/                      ← Build automation
│   │   ├── compile-vscode.sh       ← Compilar VS Code base
│   │   ├── apply-patches.sh        ← Aplicar patches SkyCode
│   │   └── build-assets.sh         ← Compilar assets
│   ├── deployment/                 ← Deploy tools
│   │   ├── upload-release.sh       ← Upload para GitHub Releases
│   │   ├── update-server.sh        ← Atualizar servidor web
│   │   └── create-checksum.sh     ← Gerar checksums de segurança
│   └── testing/                    ← Testes automatizados
│       ├── run-tests.sh            ← Suite de testes
│       ├── validate-install.sh      ← Validar instalação
│       └── performance-test.sh     ← Testes de performance
└── config/                        ← Configurações ⚙️
    ├── build.json                  ← Configurações de build
    ├── version.json                ← Controle de versão
    ├── product.json                ← Metadados do produto
    └── release.json               ← Configurações de release
```

---

## 🎨 Sistema de Branding

### 1. Logotipos e Identidade Visual

#### Logo Principal (logo.svg)
```svg
<!-- Exemplo conceitual -->
<svg width="200" height="80" viewBox="0 0 200 80">
  <!-- Sky (gradiente azul para ciano) -->
  <text x="10" y="50" font-family="Arial" font-size="32" font-weight="bold">
    <tspan fill="#007ACC">Sky</tspan>
  </text>

  <!-- Code (gradiente ciano para azul) -->
  <text x="70" y="50" font-family="Arial" font-size="32" font-weight="300">
    <tspan fill="#00C9FF">Code</tspan>
  </text>

  <!-- Ícone de nuvem/IA -->
  <circle cx="170" cy="40" r="8" fill="#FFC107" opacity="0.8"/>
  <circle cx="185" cy="35" r="6" fill="#FFC107" opacity="0.6"/>
  <circle cx="180" cy="52" r="5" fill="#FFC107" opacity="0.4"/>
</svg>
```

#### Paleta de Cores
```json
{
  "primary": {
    "sky": "#007ACC",        ← Azul VS Code original
    "skycode": "#00A8E8",   ← Azul SkyCode
    "accent": "#FFC107"      ← Amarelo IA/destaque
  },
  "secondary": {
    "surface": "#252526",    ← Fundo escuro
    "text": "#CCCCCC",       ← Texto claro
    "border": "#3E3E42"     ← Bordas
  },
  "semantic": {
    "success": "#4CAF50",
    "warning": "#FF9800",
    "error": "#F44336",
    "info": "#2196F3"
  }
}
```

### 2. Temas Customizados

#### Tema SkyCode Dark (skycode-dark.json)
```json
{
  "name": "SkyCode Dark",
  "type": "dark",
  "colors": {
    "editor.background": "#1A1A1A",
    "editor.foreground": "#E0E0E0",
    "activityBar.background": "#171717",
    "titleBar.activeBackground": "#00A8E8",
    "titleBar.activeForeground": "#FFFFFF",
    "statusBar.background": "#171717",
    "statusBar.noFolderBackground": "#007ACC",
    "statusBar.debuggingBackground": "#CC6633",
    "statusBarItem.remoteBackground": "#00A8E8",
    "sideBar.background": "#1E1E1E",
    "sideBarSectionHeader.background": "#252526",
    "tab.inactiveBackground": "#2D2D30",
    "tab.activeBackground": "#1E1E1E",
    "tab.activeForeground": "#FFFFFF",
    "editorGroupHeader.tabsBackground": "#252526",
    "editorGroup.border": "#00A8E8"
  },
  "tokenColors": [
    {
      "name": "Comments",
      "scope": ["comment", "punctuation.definition.comment"],
      "settings": { "foreground": "#6A9955" }
    },
    {
      "name": "Keywords",
      "scope": ["keyword.control"],
      "settings": { "foreground": "#569CD6" }
    }
  ]
}
```

### 3. Ícones e Splash Screen

#### Estrutura de Ícones
```
branding/icons/
├── windows/
│   ├── icon.ico              ← Ícone Windows (multi-resolução)
│   └── uninstall.ico         ← Ícone desinstalador
├── macos/
│   ├── icon.icns             ← Ícone macOS
│   └── app-icon.png          ← App Store icon
├── linux/
│   ├── icon.png              ← Ícone PNG 256x256
│   └── desktop.png           ← ícone 48x48
└── web/
    ├── favicon.ico           ← Favicon 16x16, 32x32
    ├── icon-192.png         ← PWA icon 192x192
    └── icon-512.png         ← PWA icon 512x512
```

---

## 🛠️ Scripts Principais

### 1. Build Completo (build-skycode.sh)

```bash
#!/bin/bash

# build-skycode.sh - Build completo do produto SkyCode
# Compila VS Code + aplica branding SkyCode

set -e

echo "🚀 Iniciando build do SkyCode..."

# Configurações
VERSION=$(cat ../config/version.json | jq -r '.skycode_version')
OUTPUT_DIR="../build/dist"
VSCODE_DIR="../vscode"

# 1. Sincronizar VS Code base
echo "📥 Sincronizando VS Code base..."
cd "$VSCODE_DIR"
git fetch upstream
git checkout main
git merge upstream/main

# 2. Compilar VS Code
echo "🔨 Compilando VS Code..."
nvm use 22.20.0
npm install
npm run compile-client
npm run compile-web

# 3. Aplicar Branding SkyCode
echo "🎨 Aplicando branding SkyCode..."
cd ../skycode-shell
npm run apply-branding
npm run build-themes

# 4. Aplicar Patches SkyCode
echo "🔧 Aplicando patches específicos..."
cd ../skybridge-integration
npm run apply-patches

# 5. Empacotar Produto
echo "📦 Empacotando SkyCode..."
cd ../skycode-shell
./utils/build/package-skycode.sh

echo "✅ Build SkyCode $VERSION concluído!"
echo "📂 Saída: $OUTPUT_DIR"
```

### 2. Aplicar Branding (apply-branding.js)

```javascript
// utils/build/apply-branding.js
const fs = require('fs');
const path = require('path');

// Substituir branding no VS Code compilado
function applyBranding() {
    const vscodeOut = '../vscode/out';
    const brandingDir = './branding';

    console.log('🎨 Aplicando branding SkyCode...');

    // 1. Substituir logos e ícones
    copyBrandingAssets(brandingDir + '/icons', vscodeOut + '/vs/base/browser');

    // 2. Aplicar temas customizados
    copyBrandingAssets(brandingDir + '/themes', vscodeOut + '/vs/platform/extensionData');

    // 3. Atualizar product.json
    updateProductJson();

    console.log('✅ Branding aplicado com sucesso!');
}

function updateProductJson() {
    const productPath = '../vscode/product.json';
    const product = require(productPath);

    // Branding SkyCode
    product.name = 'SkyCode';
    product.applicationName = 'skycode';
    product.nameShort = 'SkyCode';
    product.dataFolderName = 'skycode';
    product.serverDataFolderName = '.skycode-server';
    product.quality = 'skycode';

    // Visual
    product.iconPath = '../skycode-shell/branding/icons/icon.png';
    product.reportIssueUrl = 'https://github.com/h4mn/skycode/issues';
    product.licenseUrl = 'https://github.com/h4mn/skycode/blob/main/LICENSE';

    fs.writeFileSync(productPath, JSON.stringify(product, null, 2));
}
```

### 3. Script de Instalação (install-skycode.sh)

```bash
#!/bin/bash

# install-skycode.sh - Instalação automatizada do SkyCode

set -e

echo "🚀 Instalador SkyCode"
echo "===================="

# Detectar plataforma
PLATFORM=$(uname -s)
case "$PLATFORM" in
    Linux*)     OS="linux";;
    Darwin*)     OS="macos";;
    CYGWIN*|MINGW*|MSYS*) OS="windows";;
    *)           echo "❌ Plataforma não suportada: $PLATFORM"; exit 1;;
esac

echo "📋 Plataforma detectada: $OS"

# Download da versão mais recente
echo "📥 Baixando SkyCode..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/h4mn/skycode/releases/latest | jq -r '.tag_name')
DOWNLOAD_URL="https://github.com/h4mn/skycode/releases/download/$LATEST_VERSION/skycode-$OS-x64.tar.gz"

curl -L "$DOWNLOAD_URL" -o skycode.tar.gz

# Extração
echo "📂 Extraindo arquivos..."
mkdir -p ~/.local/skycode
tar -xzf skycode.tar.gz -C ~/.local/skycode --strip-components=1

# Configurar PATH
echo "🔧 Configurando ambiente..."
echo 'export PATH="$HOME/.local/skycode/bin:$PATH"' >> ~/.bashrc
echo 'export EDITOR="skycode"' >> ~/.bashrc

# Criar atalho no desktop
echo "🎯 Criando atalhos..."
cat > ~/Desktop/SkyCode.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=SkyCode
Comment=Code editor with AI integration
Exec=$HOME/.local/skycode/bin/skycode %U
Icon=$HOME/.local/skycode/icon.png
Terminal=false
Categories=Development;IDE;
EOF

# Limpeza
rm skycode.tar.gz

echo "✅ SkyCode instalado com sucesso!"
echo "🔄 Execute 'source ~/.bashrc' ou reinicie o terminal"
echo "🚀 Execute 'skycode' para iniciar o editor"
```

---

## 📦 Fluxo de Build e Distribuição

### 1. Desenvolvimento
```bash
# Desenvolver features no VS Code fork
cd ../vscode
git checkout skycode/v1.0.0
# ... fazer mudanças ...

# Aplicar branding local
cd ../skycode-shell
npm run dev-branding
```

### 2. Build de Release
```bash
# Build completo para distribuição
cd skycode-shell
./scripts/build-skycode.sh

# Resultado:
# └── ../build/dist/
#     ├── skycode-windows-x64.exe
#     ├── skycode-linux-x64.deb
#     ├── skycode-macos-x64.dmg
#     └── skycode-web.tar.gz
```

### 3. Publicação
```bash
# Criar release no GitHub
cd ../
gh release create skycode-1.107.0.1 \
  --title "SkyCode v1.107.0.1 - AI Integration Release" \
  --notes "Primeiro release estável do SkyCode com integração IA" \
  build/dist/*
```

---

## 🔗 Integração com VS Code Core

### 1. Arquivos Modificados (Versionados)
```
vscode/
├── product.json                 ← Metadados do produto (branded)
├── package.json                 ← Scripts customizados
└── out/                       ← Build com branding aplicado
    ├── vs/base/browser/         ← Ícones e assets web
    ├── vs/platform/            ← Temas e extensões
    └── main.js                ← Ponto de entrada modificado
```

### 2. Patches Não Destrutivos
```javascript
// skybridge-integration/patches/skycode-entry.js
// Extender ponto de entrada do VS Code sem quebrar sincronização

const originalMain = require('../vscode/out/main');

// Adicionar inicialização SkyCode
function skyCodeBootstrap() {
    console.log('🚀 SkyCode AI Integration starting...');
    // Inicializar módulos IA, bridges, etc.
}

// Wrapper mantendo compatibilidade
module.exports = {
    ...originalMain,
    bootstrap: skyCodeBootstrap
};
```

---

## 📊 Status Atual vs Planejado

| Componente | Status Atual | Status Planejado | Ações Necessárias |
|------------|---------------|------------------|------------------|
| Scripts Base | ✅ setup-vscode-fork.sh | ✅ build-skycode.sh | Implementar build completo |
| Branding Visual | ❌ Não implementado | 🎨 logos, temas, cores | Criar identidade visual |
| Installers | ❌ Não implementado | 📦 Win/Linux/Mac | Scripts de empacotamento |
| Utils | ❌ Não implementado | 🛠️ build/deploy/test | Ferramentas de automação |
| Config | ❌ Não implementado | ⚙️ version/product | Metadados do produto |

---

## 🎯 Próximos Passos Imediatos

1. **Criar Identidade Visual**
   ```bash
   # Criar logos baseado no conceito "Sky + Code + IA"
   # Definir paleta de cores SkyCode
   # Desenvolver temas customizados
   ```

2. **Implementar Build Script**
   ```bash
   skycode-shell/scripts/build-skycode.sh
   skycode-shell/utils/build/apply-branding.js
   ```

3. **Configurar Empacotamento**
   ```bash
   # Windows: NSIS installer
   # Linux: .DEB e .RPM packages
   # macOS: .DMG com app bundle
   ```

4. **Integrar com Build Process**
   ```bash
   # Modificar gulpfile do VS Code para aplicar branding
   # Automatizar após compilação do core
   # Gerar distribuições específicas SkyCode
   ```

---

## 🌟 Conclusão

**Arquitetura Definida**: SkyCode Shell funciona como camada de branding e automação que:

✅ **Mantém Fork Limpo**: VS Code core permanece sincronizável
✅ **Separa Responsabilidades**: Branding ↔ Core de forma organizada
✅ **Automatiza Build**: Scripts reutilizáveis para desenvolvimento e release
✅ **Facilita Distribuição**: Empacotamento multi-plataforma
✅ **Personaliza Experiência**: Temas, ícones e identidade SkyCode

**Resultado**: SkyCode se torna um produto independente com identidade própria, enquanto mantém a base do VS Code atualizável e contribuída para a comunidade.

> "SkyCode Shell: transformando VS Code base em experiência SkyCode personalizada!" – made by Sky 🎨

---
**Tags**: `#branding #skycode-shell #automation #packaging #visual-identity`