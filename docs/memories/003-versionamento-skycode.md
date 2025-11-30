# Memory 002: Estratégia de Versionamento SkyCode

**Data**: 30/11/2025
**Projeto**: SkyCode - Estratégia de Versionamento
**Status**: 📋 Estratégia Definida

---

## 🏗️ Estrutura Atual do Versionamento

### Status dos Repositórios

```
B:\_repositorios\skycode\
├── (não é Git)                    ← Diretório principal SkyCode
├── vscode/                         ← Seu fork: https://github.com/h4mn/vscode.git
│   ├── origin: h4mn/vscode        ← SEU fork pessoal
│   ├── upstream: microsoft/vscode ← Fork oficial Microsoft
│   └── package.json: "1.107.0"   ← Versão VS Code base
├── docs/stack.md                  ← Documentação técnica
└── memory-*.md                    ← Memórias do processo
```

### Estado Versionamento Atual
- **Repositório Principal**: ❌ Não inicializado como Git
- **Fork VS Code**: ✅ Configurado com upstream oficial
- **Sincronização**: ⚠️ Desatualizado (precisa sync com upstream)

---

## 🎯 Estratégia de Versionamento Recomendada

### 1. Repositório Principal SkyCode (B:\_repositorios\skycode)

**Iniciar como Git:**
```bash
# Inicializar repositório principal
git init
git add .
git commit -m "🚀 Initial commit: SkyCode project foundation

- Setup VS Code fork structure
- Documentation and build process
- Web server running on localhost:3001

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Conectar ao GitHub (criar repo skycode-h4mn)
git remote add origin https://github.com/h4mn/skycode.git
git branch -M main
git push -u origin main
```

**Purpose**:
- Manter roadmap e documentação
- Versionar scripts de build do SkyCode
- Guardar memórias do desenvolvimento
- Integrar com skybridge-integration/

### 2. Estratégia de Branches

#### no Repositório Principal (skycode/):
```
main                 ← Branch estável com releases
develop              ← Desenvolvimento ativo
feature/ia-integration ← Features específicas SkyCode
docs/atualizacao     ← Updates documentação
```

#### no Fork VS Code (vscode/):
```
main                 ← Sincronizado com microsoft/vscode/main
skycode/v1.0.0      ← Branch de desenvolvimento SkyCode
skycode/ia-features  ← Features específicas de IA
skycode/patches      ← Patches e correções
```

---

## 🔄 Fluxo de Sincronização

### Comando de Sync Automático
```bash
# Dentro do vscode/
git fetch upstream
git checkout main
git merge upstream/main  # Sincronizar com oficial
git push origin main      # Atualizar seu fork

# Criar branch de desenvolvimento
git checkout -b skycode/v1.0.0
git push origin skycode/v1.0.0
```

### Fluxo de Trabalho
1. **Semanalmente**: Sync `upstream/main` → `origin/main`
2. **Features**: Branch `skycode/v1.0.0` para desenvolvimento
3. **PRs**: Enviar patches específicos para upstream (opcional)
4. **Releases**: Tags semantic version no repositório principal

---

## 📦 Versão SkyCode - Esquema Sugerido

### Versionamento Semântico: `skycode-{vscode-base}.skycode-patch`

**Exemplos:**
- `skycode-1.107.0.1` ← Primeiro release SkyCode baseado em VS Code 1.107.0
- `skycode-1.107.0.2` ← Fix de bugs na integração IA
- `skycode-1.108.0.1` ← Atualizado para VS Code 1.108.0

### package.json do SkyCode
```json
{
  "name": "skycode",
  "version": "1.107.0.1",
  "vscode-base": "1.107.0",
  "skycode-patch": "1",
  "description": "VS Code customizado com integrações IA - Skybridge",
  "author": "h4mn"
}
```

---

## 🏷️ Estratégia de Tags

### Tags no Repositório Principal
```bash
# Release tags
git tag skycode-1.107.0.1 -m "🚀 SkyCode v1.107.0.1: Primeiro release funcional

- VS Code 1.107.0 + SkyCode IA features
- Web server funcional em localhost:3001
- Build modular independente

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin skycode-1.107.0.1
```

### Tags no Fork VS Code
```bash
# Tags de desenvolvimento
git tag skycode-1.107.0-dev -m "Development branch for SkyCode features"
git push origin skycode-1.107.0-dev
```

---

## 📁 Estrutura de Arquivos Versionados

### No Repositório Principal (skycode/)
```
skycode/
├── README.md                    ← Documentação do projeto
├── package.json                 ← Metadados SkyCode
├── version.json                 ← Controle de versão atual
├── .gitignore                  ← Excluir builds/node_modules
├── build/                      ← Builds do SkyCode
│   ├── scripts/               ← Scripts de build personalizados
│   └── outputs/               ← Binários gerados
├── skybridge-integration/      ← Módulos de IA
├── skycode-shell/             ← Branding e utilidades
├── docs/                      ← Documentação
│   ├── stack.md              ← Stack técnico
│   ├── roadmap.md            ← Roadmap de features
│   └── versionamento.md      ← Este documento
├── memory/                    ← Memórias do desenvolvimento
│   ├── memory-001-*.md
│   └── memory-002-*.md
└── experiments/               ← Protótipos e testes
```

### Não Versionar (add .gitignore)
```
# Builds e dependências
vscode/out/
vscode/node_modules/
vscode/.build/
vscode/.vscode-test/

# Logs e temporários
*.log
.temp/
.cache/

# Environment
.env
.env.local
```

---

## 🚀 Release Process

### 1. Preparação de Release
```bash
# 1. Sync VS Code base
cd vscode
git fetch upstream
git checkout main
git merge upstream/main

# 2. Atualizar branch skycode
git checkout skycode/v1.0.0
git merge main

# 3. Compilar e testar
nvm use 22.20.0
npm install
npm run compile-client
./scripts/code-web.sh . --port 3001  # Testar

# 4. Voltar ao repositório principal
cd ..
```

### 2. Criar Release SkyCode
```bash
# 1. Atualizar versão
echo '{"version":"skycode-1.107.0.1","vscode-base":"1.107.0","skycode-patch":"1"}' > version.json

# 2. Commit e tag
git add .
git commit -m "🚀 Release skycode-1.107.0.1: IA integration complete

- VS Code 1.107.0 base updated
- Skybridge IA modules integrated
- Web server with customizations
- Performance optimizations

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git tag skycode-1.107.0.1
git push origin main
git push origin skycode-1.107.0.1
```

---

## 🔄 Integração Contínua (Futuro)

### GitHub Actions Sugerido
```yaml
name: SkyCode Build
on:
  push:
    tags: ['skycode-*']

jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '22.20.0'

      - name: Sync VS Code
        run: |
          cd vscode
          git fetch upstream
          git merge upstream/main

      - name: Build SkyCode
        run: |
          cd vscode
          npm install
          npm run compile-client

      - name: Create Release
        uses: actions/create-release@v1
        with:
          tag_name: ${{ github.ref }}
          release_name: SkyCode ${{ github.ref }}
```

---

## ✅ Próximos Passos Imediatos

1. **Criar Repositório SkyCode** no GitHub:
   ```bash
   # Acessar github.com/h4mn → New Repository → "skycode"
   ```

2. **Inicializar Git principal**:
   ```bash
   cd B:\_repositorios\skycode
   git init
   git add .
   git commit -m "Initial SkyCode foundation"
   git remote add origin https://github.com/h4mn/skycode.git
   git push -u origin main
   ```

3. **Documentar roadmap** em `docs/roadmap.md`:
   - Features planejadas
   - Timeline de releases
   - Ponto de integração IA

---

## 🌟 Conclusão

**ESTRATÉGIA DEFINIDA**: Dual-repositório com sync automático

- **skycode/**: Repositório principal para releases e documentação
- **vscode/**: Fork sincronizado com upstream para desenvolvimento
- **Versionamento semântico**: SkyCode sobre VS Code base
- **CI/CD**: Automatização de builds e releases

Esta estratégia permite:
✅ Manter fork limpo e sincronizável
✅ Versionar features SkyCode independentemente
✅ Contribuir patches para VS Code oficial futuramente
✅ Build automatizado e releases gerenciados

> "Estratégia de versionamento definida: SkyCode pronto para evolução sustentável!" – made by Sky 🏷️

---
**Tags**: `#versionamento #git-strategy #skycode-architecture #release-management`