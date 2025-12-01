# SkyCode Scripts

Coleção de scripts para automação e configuração do projeto SkyCode.

---

## 🔧 Scripts Disponíveis

### 📋 Setup e Configuração

#### `setup-vscode-fork.sh` / `setup-vscode-fork.ps1`
**Propósito**: Configuração inicial do fork VS Code para desenvolvimento SkyCode
**Status**: ✅ Funcional
**Uso**:
```bash
# Linux/macOS
./setup-vscode-fork.sh

# Windows
.\setup-vscode-fork.ps1
```

#### `fix-github-mcp.js`
**Propósito**: Configura automática do MCP GitHub para Claude Code
**Status**: ✅ Funcional - Token configurado
**Uso**:
```bash
node fix-github-mcp.js
```

#### `setup-github-mcp.ps1` (PowerShell)
**Propósito**: Configuração MCP GitHub via PowerShell
**Status**: 🔄 Em desenvolvimento - Bug de encoding detectado

#### `setup-github-mcp.bat` (Batch)
**Propósito**: Configuração MCP GitHub via Batch
**Status**: 🔄 Em desenvolvimento

---

## 🎨 Scripts de Build (Planejados)

### `build-skycode.sh` (Planejado)
**Propósito**: Build completo do produto SkyCode
**Status**: 🔄 Planejado para Fase 2
**Funcionalidades**:
- Sincronizar VS Code upstream
- Compilar VS Code base
- Aplicar branding SkyCode
- Empacotar produto final

### `apply-branding.sh` (Planejado)
**Propósito**: Aplicar identidade visual SkyCode
**Status**: 🔄 Planejado para Fase 2
**Funcionalidades**:
- Aplicar logos e ícones
- Configurar temas customizados
- Atualizar product.json

---

## 🔄 Scripts de Sincronização (Planejados)

### `sync-upstream.sh` (Planejado)
**Propósito**: Sincronizar fork VS Code com upstream oficial
**Status**: 🔄 Planejado
**Uso**:
```bash
# Atualizar fork com mudanças oficiais
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

---

## 📦 Scripts de Empacotamento (Planejados)

### `package-skycode.sh` (Planejado)
**Propósito**: Empacotar SkyCode para distribuição
**Status**: 🔄 Planejado para Fase 4
**Plataformas**:
- Windows: `.exe` via NSIS
- Linux: `.deb` / `.rpm`
- macOS: `.dmg` via app bundle
- Web: `.tar.gz` (PWA)

---

## 🔍 Scripts de Validação (Planejados)

### `validate-install.sh` (Planejado)
**Propósito**: Validar instalação do SkyCode
**Status**: 🔄 Planejado
**Validações**:
- Verificar dependências
- Testar build do VS Code
- Validar configuração MCP
- Checar permissões

### `performance-test.sh` (Planejado)
**Propósito**: Testes de performance do SkyCode
**Status**: 🔄 Planejado para Fase 3
**Métricas**:
- Tempo de inicialização
- Consumo de memória
- Performance de build
- Benchmarks de features

---

## 📋 Estrutura de Scripts

```
scripts/
├── 📋 Configuração
│   ├── setup-vscode-fork.sh      ✅ Setup inicial fork VS Code
│   ├── setup-vscode-fork.ps1       ✅ Versão Windows PowerShell
│   ├── fix-github-mcp.js           ✅ Configuração MCP GitHub
│   ├── setup-github-mcp.ps1          🔄 Configuração MCP (PS1)
│   └── setup-github-mcp.bat          🔄 Configuração MCP (Batch)
├── 🎨 Build
│   ├── build-skycode.sh              🔄 Build completo produto
│   ├── apply-branding.sh              🔄 Aplicar branding
│   └── compile-vscode.sh             ✅ Compilar VS Code core
├── 🔄 Sincronização
│   └── sync-upstream.sh               🔄 Sync com upstream
├── 📦 Empacotamento
│   ├── package-windows.sh               🔄 Empacotar Windows
│   ├── package-linux.sh                🔄 Empacotar Linux
│   ├── package-macos.sh                🔄 Empacotar macOS
│   └── package-web.sh                 🔄 Empacotar Web
├── 🔍 Validação
│   ├── validate-install.sh              🔄 Validar instalação
│   └── performance-test.sh            🔄 Testes performance
└── 🛠️ Utilidades
    ├── create-shortcuts.sh              🔄 Criar atalhos
    ├── setup-environment.sh             🔄 Configurar ambiente
    └── clean-build.sh                  🔄 Limpar builds
```

---

## 🚀 Como Usar os Scripts

### Setup Inicial (Fase 1 - Concluída)
```bash
# 1. Clonar e configurar repositório
git clone https://github.com/h4mn/skycode.git
cd skycode

# 2. Configurar fork VS Code
./scripts/setup-vscode-fork.sh

# 3. Configurar MCP GitHub para Claude Code
node scripts/fix-github-mcp.js
```

### Build e Desenvolvimento (Fase 2 - Em Andamento)
```bash
# 1. Compilar VS Code base
cd vscode
npm run compile-client

# 2. Aplicar branding SkyCode
cd ../skycode-shell
./scripts/apply-branding.sh

# 3. Empacotar produto
./scripts/package-skycode.sh
```

---

## 🔧 Configuração de Ambiente

### Requisitos
- **Node.js**: 22.20.0 (conforme .nvmrc)
- **GitHub CLI**: Configurado com `gh auth login`
- **NPM**: Para desenvolvimento VS Code
- **Python**: 3.13+ para MCPs e ferramentas

### Variáveis de Ambiente
- `SKYCODE_ROOT`: Diretório raiz do projeto
- `VSCODE_FORK_PATH`: Caminho para o fork VS Code
- `SKYCODE_SHELL_PATH`: Caminho para scripts SkyCode
- `GITHUB_TOKEN`: Token GitHub para MCP (automático via script)

---

## 📊 Status dos Scripts

| Script | Status | Versão | Última Atualização |
|--------|---------|---------|------------------|
| setup-vscode-fork.sh | ✅ Funcional | 1.0 | 30/11/2025 |
| setup-vscode-fork.ps1 | ✅ Funcional | 1.0 | 30/11/2025 |
| fix-github-mcp.js | ✅ Funcional | 1.0 | 30/11/2025 |
| build-skycode.sh | 🔄 Planejado | - | - |
| apply-branding.sh | 🔄 Planejado | - | - |
| sync-upstream.sh | 🔄 Planejado | - | - |
| package-skycode.sh | 🔄 Planejado | - | - |

---

## 🎯 Roadmap de Scripts

### Fase 2: Scripts de Build e Branding
- [ ] Implementar build-skycode.sh completo
- [ ] Criar apply-branding.sh funcional
- [ ] Desenvolver package-windows.sh
- [ ] Configurar package-linux.sh

### Fase 3: Scripts de IA e Performance
- [ ] Scripts de integração Skybridge
- [ ] Ferramentas de performance
- [ ] Testes automatizados

### Fase 4: Scripts de Distribuição
- [ ] CI/CD GitHub Actions
- [ ] Scripts de release automático
- [ ] Ferramentas de validação

---

## 🛠️ Desenvolvimento de Scripts

### Convenções
- **Linguagem**: JavaScript/Node.js para cross-platform
- **Documentação**: Comentários detalhados em português
- **Error Handling**: Try-catch com mensagens claras
- **Logging**: Emojis para melhor visualização
- **Testes**: Validação de pré-requisitos

### Contribuição
- Fork do repositório: https://github.com/h4mn/skycode
- Scripts em: `scripts/` directory
- Testar em múltiplas plataformas
- Manter documentação atualizada

> "Scripts SkyCode: automação para desenvolvimento distribuído!" – made by Sky 🚀

---

**Tags**: `#scripts #automation #skycode #build-system #devops`