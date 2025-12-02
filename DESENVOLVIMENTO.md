# Guia de Desenvolvimento SkyCode

## Visão Geral

Este guia explica como desenvolver e testar o SkyCode com internacionalização pt-BR.

## Requisitos

- Node.js 22.20.0+
- Windows 10/11
- Git
- VS Code Fork já clonado em `vscode/`

## Scripts de Desenvolvimento

### 1. skycode-dev.bat (Recomendado)
**Aplica i18n + compila + inicia VS Code com pt-BR**

```bash
# Primeiro uso (aplica i18n e compila)
scripts\skycode-dev.bat

# Uso normal (apenas inicia se já compilado)
scripts\skycode-dev.bat
```

### 2. skycode-compile.bat
**Apenas aplica internacionalização e compila**

```bash
scripts\skycode-compile.bat
```

### 3. skycode-run.bat
**Inicia VS Code já compilado (mais rápido)**

```bash
scripts\skycode-run.bat
```

### 4. apply-i18n.js
**Apenas aplica internacionalização (sem compilar)**

```bash
node scripts\apply-i18n.js
```

## Fluxo de Trabalho Recomendado

### Primeiro Uso
```bash
# Este script faz tudo: i18n + compilação + inicialização
scripts\skycode-dev.bat
```

### Desenvolvimento Contínuo
```bash
# Se você modificou algo no VS Code:
scripts\skycode-compile.bat

# Para iniciar rapidamente:
scripts\skycode-run.bat

# Ou se prefere o processo completo (mais seguro):
scripts\skycode-dev.bat
```

## Internacionalização pt-BR

### Onde as traduções ficam
- **Fonte**: `scripts/modules/skycode-i18n/ptb/`
- **Destino**: `vscode/i18n/ptb/` (aplicado pelo script)

### Como testar internacionalização

1. **Através do script (padrão)**:
   ```bash
   scripts\skycode-run.bat
   ```

2. **Manualmente no VS Code compilado**:
   ```bash
   cd vscode
   node build/lib/electron.js . --locale=ptb
   ```

3. **Configuração persistente (settings.json)**:
   ```json
   {
     "locale": "ptb"
   }
   ```

### Modo alternativo (sem modificar fork)
Use o VS Code oficial com:
- Extensão de idioma pt-BR da Microsoft
- Configuração `"locale": "ptb"`

## Estrutura de Arquivos

```
B:\_repositorios\skycode\
├── scripts/
│   ├── skycode-dev.bat         ← Script principal
│   ├── skycode-compile.bat     ← Apenas compila
│   ├── skycode-run.bat         ← Apenas executa
│   ├── apply-i18n.js          ← Aplica internacionalização
│   └── modules/skycode-i18n/  ← Traduções pt-BR
├── vscode/                     ← Fork do VS Code
└── docs/
    └── DESENVOLVIMENTO.md     ← Este arquivo
```

## Troubleshooting

### Erro: 'head' não é reconhecido
**Solução**: O script `apply-i18n.js` já foi corrigido para ser cross-platform.

### VS Code não inicia em português
**Verifique**:
1. Se `vscode/i18n/ptb/main.i18n.json` existe
2. Se está usando `--locale=ptb`
3. Se o VS Code foi compilado após aplicar i18n

### Compilação muito demorada
**Normal**: Primeira compilação pode levar 5-15 minutos.
**Posteriores**: Mudanças incrementais são mais rápidas.

### Erro de dependências
**Solução**:
```bash
cd vscode
npm install
```

## Debug e Desenvolvimento

### Logs do VS Code
Os scripts habilitam automaticamente:
- `ELECTRON_ENABLE_LOGGING=1`
- `ELECTRON_ENABLE_STACK_DUMPING=1`

### DevTools
Pressione `F12` ou `Ctrl+Shift+I` no VS Code para abrir DevTools.

## Contribuindo com Traduções

1. Edite arquivos em `scripts/modules/skycode-i18n/ptb/`
2. Execute `node scripts/apply-i18n.js`
3. Compile e teste com `scripts\skycode-dev.bat`

## Próximos Passos

- [ ] Adicionar suporte para outros idiomas
- [ ] Criar script de packaging
- [ ] Integrar com CI/CD

---

> "Cada linha de código nos aproxima do desenvolvedor brasileiro" – made by Sky 🌍