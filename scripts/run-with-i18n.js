// SkyCode VS Code Runner with i18n
// Executa VS Code com suporte a internacionalização pt-BR

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🌍 Iniciando VS Code com internacionalização pt-BR...\n');

// Caminhos
const vscodePath = path.join(__dirname, '..', 'vscode');
const i18nPath = path.join(__dirname, 'modules', 'skycode-i18n', 'ptb');

// Verificar pré-requisitos
if (!fs.existsSync(vscodePath)) {
    console.error('❌ Diretório VS Code não encontrado');
    process.exit(1);
}

if (!fs.existsSync(i18nPath)) {
    console.error('❌ Traduções pt-BR não encontradas. Execute apply-i18n.js primeiro.');
    process.exit(1);
}

console.log('📁 VS Code:', vscodePath);
console.log('📁 i18n pt-BR:', i18nPath);

// 1. Aplicar tradução se necessário
const vscodeI18nPath = path.join(vscodePath, 'i18n', 'ptb');
if (!fs.existsSync(vscodeI18nPath)) {
    console.log('📋 Aplicando traduções pt-BR...');
    try {
        execSync('node ' + path.join(__dirname, 'apply-i18n.js'), {
            stdio: 'inherit'
        });
        console.log('✅ Traduções aplicadas');
    } catch (error) {
        console.error('❌ Erro ao aplicar traduções:', error.message);
        process.exit(1);
    }
} else {
    console.log('✅ Traduções já aplicadas');
}

// 2. Carregar mensagens de tradução
const mainI18nPath = path.join(vscodeI18nPath, 'main.i18n.json');
let nlsMessages = {};

try {
    if (fs.existsSync(mainI18nPath)) {
        const content = fs.readFileSync(mainI18nPath, 'utf8');
        const i18nData = JSON.parse(content);
        nlsMessages = i18nData.contents || {};
    }
} catch (error) {
    console.warn('⚠️  Não foi possível carregar mensagens i18n:', error.message);
}

// 3. Configurar variáveis de ambiente e executar
console.log('\n🚀 Iniciando VS Code com pt-BR...');
console.log(`📋 Mensagens carregadas: ${Object.keys(nlsMessages).length}`);

// Configurar ambiente para runtime
const runEnv = {
    ...process.env,
    VSCODE_NLS_LANGUAGE: 'ptb',
    _VSCODE_NLS_LANGUAGE: 'ptb',
    _VSCODE_NLS_MESSAGES: JSON.stringify(nlsMessages)
};

try {
    process.chdir(vscodePath);

    // Executar VS Code com localização
    console.log('🔧 Iniciando Electron com locale pt-BR...');
    execSync('npm run electron -- --locale=ptb', {
        stdio: 'inherit',
        env: runEnv
    });

} catch (error) {
    console.error('❌ Erro ao iniciar VS Code:', error.message);
    process.exit(1);
}

console.log('\n✅ VS Code iniciado com sucesso!');
console.log('\n🎯 Para verificar se funcionou:');
console.log('   1. Vá em File → Preferences → Configure Language');
console.log('   2. Procure por "Português (Brasil)" na lista');
console.log('   3. Recarregue com Ctrl+R');
console.log('\n💡 Dica: Se os menus estiverem em português, funcionou!');

console.log('\n📚 Troubleshooting:');
console.log('   • Se não funcionou: Verifique se as traduções foram aplicadas');
console.log('   • Se parcialmente: Recompile com npm run compile');
console.log('   • Se errorou: Verifique o console para detalhes');

console.log('\n> "A melhor tradução é aquela que o usuário nem percebe" – made by Sky 🌍');