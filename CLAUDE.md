# CLAUDE.md

Este arquivo fornece orientações para o Claude Code (claude.ai/code) ao trabalhar com código neste repositório.

## Visão Geral do Projeto

SkyCode é uma distribuição customizada do VS Code com integrações de IA (Skybridge). O projeto segue uma arquitetura modular onde o core do VS Code permanece como um fork limpo enquanto funcionalidades customizadas são desenvolvidas de forma independente.

### Idioma do Projeto

**Língua Principal**: Português Brasileiro (pt-BR)

Todo o projeto SkyCode é desenvolvido e documentado primariamente em português brasileiro:
- Documentação técnica e guias em pt-BR
- Comentários de código e estruturas em pt-BR
- Interface e branding localizados para pt-BR
- Roadmap e planejamento em português
- Comunicação e issue tracking em português

**Suporte Internacional**: Embora o foco seja pt-BR, o código mantém:
- Nomes de variáveis e funções em inglês (padrão de desenvolvimento)
- Integrações com APIs externas em inglês
- Suporte para contribuições multilíngues

## Estrutura do Repositório

```
B:\_repositorios\skycode\
├── skycode/                 ← Repositório principal (este) - roadmap, docs, visão
├── vscode/                  ← Fork limpo do VS Code oficial
├── skybridge-integration/   ← Módulos de integração com IA
├── skycode-shell/           ← Scripts, branding e utilidades
├── build/                   ← Saídas de build
├── experiments/             ← Protótipos isolados
└── docs/
    └── stack.md            ← Stack de tecnologia e guia de setup
```

## Memórias do Claude
Consulte as memórias que criamos durante os primeiros testes em `docs\memories`

## Comandos de Desenvolvimento

### Manutenção do Fork VS Code
```bash
# Sincronizar com upstream
git fetch upstream
git checkout main
git merge upstream/main
# OU para histórico linear
git rebase upstream/main
```

## Stack de Tecnologia

- **Node.js 22.20.0** (requerido para builds do VS Code)
- **Yarn Classic v1** (gerenciamento de pacotes)
- **Git** (controle de versão)
- **MinGW + Python3** (ferramentas de build via Chocolatey)
- **Windows Chocolatey** (gerenciador de pacotes)

## Princípios de Arquitetura

1. **Estratégia de Fork Limpo**: Manter VS Code como fork limpo e sincronizável para evitar conflitos com upstream
2. **Integração Modular**: Desenvolver features de IA de forma independente em skybridge-integration/
3. **Separação de Responsabilidades**: Build tools, branding e utilidades vivem em módulos separados
4. **Evolução Mantível**: Evitar criar um "Frankenstein" de patches

## Pontos de Integração Skybridge

Integrações de IA devem ser desenvolvidas como módulos independentes que se conectam ao VS Code em pontos de integração definidos. Os pontos exatos estão sendo mapeados como parte do roadmap do projeto.

## Fluxo de Trabalho

1. Mudanças no core do VS Code acontecem no fork `vscode/` separado
2. Features específicas do SkyCode, branding e integrações vivem neste repositório principal
3. Saídas de build e experimentos são mantidos em seus próprios diretórios
4. Todas as decisões arquiteturais e itens do roadmap são documentados em `docs/`

## Observações Importantes

- O fork do VS Code deve permanecer o mais limpo possível para fácil sincronização com upstream
- Integrações Skybridge devem ser desenvolvidas como módulos independentes
- Processos de build e debugging são projetados para serem previsíveis e mantíveis

> "Construindo o futuro do desenvolvimento de código com IA integrada" – made by Sky 🚀