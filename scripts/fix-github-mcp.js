// SkyCode MCP GitHub Fix Script
// Configura o MCP GitHub para Claude Code

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🚀 Configurando MCP GitHub para Claude Code...\n');

// Obter token do GitHub CLI
let token;
try {
    console.log('🔑 Obtendo token do GitHub CLI...');
    const output = execSync('gh auth token', { encoding: 'utf8' }).trim();
    if (output) {
        token = output.split('gho_')[1] || output; // Pega só o token
        console.log('✅ Token GitHub obtido com sucesso');
    } else {
        throw new Error('Nenhum token encontrado');
    }
} catch (error) {
    console.error('❌ Erro ao obter token GitHub:', error.message);
    console.log('Execute: gh auth login');
    process.exit(1);
}

// Configurar caminhos
const userDir = process.env.USERPROFILE;
const mcpDir = path.join(userDir, '.claude');
const mcpFile = path.join(mcpDir, 'mcp.json');
const mcpBackup = path.join(mcpDir, 'mcp.json.backup');

// Criar diretório se não existir
if (!fs.existsSync(mcpDir)) {
    fs.mkdirSync(mcpDir, { recursive: true });
    console.log('📁 Criado diretório:', mcpDir);
}

// Fazer backup se o arquivo existir
if (fs.existsSync(mcpFile)) {
    console.log('💾 Fazendo backup do arquivo MCP existente...');
    fs.copyFileSync(mcpFile, mcpBackup);
}

console.log('🔧 Configurando MCP GitHub...');

// Ler arquivo MCP existente ou criar nova estrutura
let mcpConfig;
try {
    if (fs.existsSync(mcpFile)) {
        const content = fs.readFileSync(mcpFile, 'utf8');
        mcpConfig = JSON.parse(content);
    } else {
        mcpConfig = { mcpServers: {} };
    }
} catch (error) {
    mcpConfig = { mcpServers: {} };
}

// Remover configuração anterior do GitHub se existir
if (mcpConfig.mcpServers && mcpConfig.mcpServers.github) {
    console.log('🗑️ Removendo configuração anterior do GitHub...');
    delete mcpConfig.mcpServers.github;
}

// Adicionar nova configuração do GitHub
const githubConfig = {
    command: "npx",
    args: ["-y", "@modelcontextprotocol/server-github"],
    env: {
        GITHUB_PERSONAL_ACCESS_TOKEN: token
    },
    alwaysAllow: [
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
    ]
};

mcpConfig.mcpServers.github = githubConfig;

// Salvar arquivo MCP formatado
const mcpJson = JSON.stringify(mcpConfig, null, 2);
fs.writeFileSync(mcpFile, mcpJson, 'utf8');

console.log('✅ MCP GitHub configurado com sucesso!');
console.log('');
console.log('📁 Arquivo:', mcpFile);
console.log('💾 Backup:', mcpBackup);
console.log('');
console.log('🔄 Reinicie o Claude Code para carregar o MCP GitHub');
console.log('🌐 Para testar, tente usar comandos GitHub no Claude Code');
console.log('');
console.log('🎯 GitHub MCP Server disponível!');