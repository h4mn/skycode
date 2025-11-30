# Stack SkyCode

Este documento descreve, de forma clara e prática, o stack mínimo necessário para compilar, manter e evoluir sua própria distribuição do VS Code (SkyCode), junto com a estrutura organizacional recomendada.

---

## 1. Estrutura de diretórios recomendada
Crie uma pasta-mãe para o ecossistema SkyCode:

```
B:\_repositorios\skycode\
```

Dentro dela, mantenha subpastas separadas:

```
skycode/                 ← seu repositório principal (roadmap, docs, visão)
vscode/                  ← fork oficial do VS Code
skybridge-integration/   ← módulos de integração com IA
skycode-shell/           ← scripts, branding e utilidades
build/                   ← saídas de build
experiments/             ← protótipos isolados
```

Essa separação deixa o VS Code limpo para sincronizar com o upstream e evita conflitos ao longo do desenvolvimento.

---

## 2. Ferramentas necessárias

### Node.js
O VS Code requer uma versão específica do Node.
Use `nvm-windows` para gerenciar versões:

- Baixe o instalador: `nvm-setup.exe` versão estável
- Após instalar:
```
nvm install 22.20.0
nvm use 22.20.0
```

**⚠️ IMPORTANTE (Atualizado Nov/2025):**
- **Versão exata no .nvmrc**: Node.js **22.20.0** (funcionando em 30/11/2025)
- **Recomendado**: Node.js **22.20.0** (versão testada)
- **Não suportado**: Node.js 24.x (falha em módulos nativos), Node.js 16.x (descontinuado)

*Fonte: [Documentação oficial VS Code CONTRIBUTING.md](https://github.com/microsoft/vscode/blob/main/CONTRIBUTING.md)*

### Git
Tenha Git atualizado e configurado:
```
git config --global user.name "Seu Nome"
git config --global user.email "seuemail@example.com"
```

### Yarn (Classic) vs NPM
**⚠️ IMPORTANTE (Atualizado Nov/2025):**
- **VS Code Interno**: Utiliza **NPM** (migração de Yarn → NPM concluída Out/2024)
- **Projetos Externos**: Suporte a Yarn/NPM continua intacto
- **Desenvolvimento VS Code**: **Apenas NPM** é suportado (`npm i`)

*Fontes: [Issue #196795](https://github.com/microsoft/vscode/issues/196795), [Issue #227905](https://github.com/microsoft/vscode/issues/227905)*

Para desenvolvimento do VS Code:
```
npm i  # NÃO use yarn - bloqueado pelo preinstall.ts
```

Para projetos externos:
```
npm install --global yarn  # Ainda útil para seus projetos
```

### Ferramentas de Build
Instale os compiladores e utilidades necessários:

**Via Chocolatey (recomendado):**
```
choco install visualstudio2022buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended" -y
choco install python3 --confirm
```

**Ou manualmente:**
- Visual Studio 2022 Community (com workload "Desktop development with C++")
- Python 3.13+
- Windows SDK

**⚠️ IMPORTANTE (Atualizado Nov/2025):**
- **Spectre Mitigations**: Obrigatórias para compilar módulos nativos do VS Code
- **Build Tools**: VS Build Tools 2022 com C++ tools
- **Erro comum**: `MSB8040: Spectre mitigations are required`

---

## 3. Preparando o fork do VS Code

1. Forkar o repositório oficial em GitHub.
2. Clonar dentro da pasta `vscode/`:
```
cd B:\_repositorios\skycode\vscode
```
3. Fazer o clone do seu fork:
```
git clone https://github.com/seuusuario/vscode.git
```
4. Adicionar upstream oficial:
```
cd vscode
git remote add upstream https://github.com/microsoft/vscode.git
```

### Mantendo o fork atualizado
```
git fetch upstream
git checkout main
git merge upstream/main
```
Ou, se preferir linearidade:
```
git rebase upstream/main
```

---

## 4. Instalando dependências do VS Code

Dentro da pasta do fork:
```
npm i
```

**⚠️ Solução de problemas:**
- **Erro Spectre**: Instale Visual Studio Build Tools com C++ tools
- **Erro de permissão**: Execute choco como Administrador
- **Alternativa**: `npm i --ignore-scripts` (pula módulos nativos)
- **Versão incorreta Node.js**: Use exatamente a versão do .nvmrc (22.20.0). Node.js 24.x falha em módulos nativos (tree-sitter, etc.)

Para testar o build:
```
npx gulp compile
npx gulp web
```

Para abrir a versão desktop:
```
npx gulp watch
./scripts/code.bat
```

**⚠️ Nota**: `npx gulp` substitui `yarn gulp` pois o VS Code agora usa NPM internamente.

---

## 5. Repositório principal SkyCode

No diretório raiz `skycode/`, crie seu repo para manter:
- Documentação
- Decisões arquiteturais
- Roadmap
- Integrações Skybridge
- Branding e visão geral

Estrutura mínima sugerida:
```
skycode/
  docs/
    stack.md
    roadmap.md
    architecture.md
  src/
  integrations/
  README.md
```

---

## 6. Objetivo da separação
Manter o VS Code como fork limpo e estável garante que:
- Você pode sincronizar com o upstream sem conflitos sérios.
- Suas integrações ficam independentes.
- O SkyCode evolui sem virar um Frankenstein de patches.
- Build e debugging ficam muito mais previsíveis.

---

## 7. Próximos passos
- Definir identidade visual do SkyCode.
- Mapear pontos de integração com a Skybridge.
- Criar scripts de build automatizados.
- Criar seu primeiro patch leve no VS Code.

---

## 8. Histórico de Mudanças

### Nov/2025 - Atualização Node.js e Package Manager
- **Node.js**: 18.18.2 → 20.x LTS → **22.20.0** (versão testada)
- **Package Manager**: **Yarn → NPM** para desenvolvimento VS Code (migração concluída Out/2024)
- **Motivo**: NPM se equiparou em performance e Yarn v1 estava menos mantido
- **Impacto**: Apenas afeta desenvolvimento interno do VS Code, projetos externos mantêm suporte a ambos
- **Funcionando**: Node.js 22.20.0 em 30/11/2025
- **Fontes**: [Issue #196795](https://github.com/microsoft/vscode/issues/196795), [Issue #227905](https://github.com/microsoft/vscode/issues/227905)

### Nov/2025 - Build Tools Windows
- **Spectre Mitigations**: Agora obrigatórias para compilar módulos nativos VS Code
- **Build Tools**: VS 2022 Build Tools com C++ tools necessário
- **Erro comum**: `MSB8040: Spectre mitigations are required`
- **Solução**: Instalar via Chocolatey com parâmetros corretos ou VS Community com C++ workload

---

Este documento deve ser colocado em `docs/stack.md` dentro do seu repositório principal SkyCode.