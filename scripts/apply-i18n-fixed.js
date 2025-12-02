// SkyCode i18n Applier (Fixed Version)
// Aplica localização pt-BR no VS Code - Versão corrigida

const fs = require('fs');
const path = require('path');

console.log('🌍 Aplicando localização pt-BR no VS Code...\n');

// Caminhos absolutos para evitar problemas
const vscodePath = path.resolve(__dirname, '..', 'vscode');
const i18nPath = path.resolve(__dirname, 'modules', 'skycode-i18n');
const ptbPath = path.resolve(i18nPath, 'ptb');
const vscodeI18nPath = path.resolve(vscodePath, 'i18n', 'ptb');

// Verificar se os diretórios existem
if (!fs.existsSync(vscodePath)) {
    console.error('❌ Diretório VS Code não encontrado:', vscodePath);
    process.exit(1);
}

if (!fs.existsSync(i18nPath)) {
    console.error('❌ Módulo i18n não encontrado:', i18nPath);
    process.exit(1);
}

console.log('📁 VS Code:', vscodePath);
console.log('📁 i18n pt-BR:', ptbPath);

// Remover localização anterior se existir
if (fs.existsSync(vscodeI18nPath)) {
    console.log('🗑️  Removendo localização pt-BR anterior...');
    try {
        fs.rmSync(vscodeI18nPath, { recursive: true, force: true });
        console.log('✅ Localização anterior removida');
    } catch (error) {
        console.warn('⚠️  Não foi possível remover:', error.message);
    }
}

// Criar diretório destino se não existir
if (!fs.existsSync(vscodeI18nPath)) {
    fs.mkdirSync(vscodeI18nPath, { recursive: true });
    console.log('📁 Diretório criado:', vscodeI18nPath);
}

// Copiar arquivos de forma segura
const copyFile = (src, dest) => {
    try {
        fs.copyFileSync(src, dest);
        console.log(`   📄 ${path.basename(dest)}`);
    } catch (error) {
        console.error(`   ❌ Erro ao copiar ${path.basename(dest)}:`, error.message);
    }
};

const copyDir = (src, dest) => {
    try {
        const entries = fs.readdirSync(src);
        console.log(`   📁 ${path.basename(dest)}/`);

        entries.forEach(entry => {
            const srcPath = path.join(src, entry);
            const destPath = path.join(dest, entry);

            if (fs.statSync(srcPath).isDirectory()) {
                // Criar diretório se não existir
                if (!fs.existsSync(destPath)) {
                    fs.mkdirSync(destPath, { recursive: true });
                }
                copyDir(srcPath, destPath);
            } else {
                copyFile(srcPath, destPath);
            }
        });

        console.log(`   ✅ ${entries.length} arquivos copiados`);
    } catch (error) {
        console.error('❌ Erro ao copiar diretório:', error.message);
    }
};

// Copiar arquivos principais
console.log('📋 Copiando arquivos principais...');
copyFile(path.join(ptbPath, 'main.i18n.json'), path.join(vscodeI18nPath, 'main.i18n.json'));
copyFile(path.join(ptbPath, 'package.json'), path.join(vscodeI18nPath, 'package.json'));

// Copiar extensões
const extensionsSrc = path.join(ptbPath, 'extensions');
const extensionsDest = path.join(vscodeI18nPath, 'extensions');
copyDir(extensionsSrc, extensionsDest);

console.log('\n✅ Localização pt-BR aplicada com sucesso!');
console.log(`📂 Arquivos copiados para: ${vscodeI18nPath}`);
console.log('\n🎯 Para usar: execute "npm run electron -- --locale=ptb"');