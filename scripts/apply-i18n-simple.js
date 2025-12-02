// SkyCode i18n Applier - Versão Final
// Aplica localização pt-BR de forma simples e compatível

const fs = require('fs');
const path = require('path');

console.log('🌍 Aplicando localização pt-BR no VS Code...');

// Usar path.resolve para caminhos absolutos
const vscodePath = path.resolve(__dirname, '..', 'vscode');
const i18nPath = path.resolve(__dirname, 'modules', 'skycode-i18n');
const ptbPath = path.resolve(i18nPath, 'ptb');
const vscodeI18nPath = path.resolve(vscodePath, 'i18n', 'ptb');

// Verificar pré-requisitos
if (!fs.existsSync(vscodePath) || !fs.existsSync(i18nPath)) {
    console.error('❌ Diretórios VS Code ou i18n não encontrados');
    process.exit(1);
}

console.log('📁 VS Code:', vscodePath);
console.log('📁 i18n pt-BR:', ptbPath);

// Remover localização anterior
if (fs.existsSync(vscodeI18nPath)) {
    console.log('🗑️  Removendo localização anterior...');
    try {
        fs.rmSync(vscodeI18nPath, { recursive: true, force: true });
        console.log('✅ Localização anterior removida');
    } catch (error) {
        console.warn('⚠️  Erro ao remover:', error.message);
    }
}

// Criar diretório e cópia
try {
    if (!fs.existsSync(vscodeI18nPath)) {
        fs.mkdirSync(vscodeI18nPath, { recursive: true });
        console.log('📁 Diretório criado:', vscodeI18nPath);
    }

    // Copiar arquivos principais
    const mainSrc = ptbPath + '/main.i18n.json';
    const mainDest = vscodeI18nPath + '/main.i18n.json';
    const packageSrc = ptbPath + '/package.json';
    const packageDest = vscodeI18nPath + '/package.json';

    fs.copyFileSync(mainSrc, mainDest);
    fs.copyFileSync(packageSrc, packageDest);

    console.log('✅ main.i18n.json copiado');
    console.log('✅ package.json copiado');

    // Copiar extensões
    const extensionsSrc = ptbPath + '/extensions';
    const extensionsDest = vscodeI18nPath + '/extensions';

    if (fs.existsSync(extensionsSrc)) {
        fs.mkdirSync(extensionsDest, { recursive: true });

        const extensions = fs.readdirSync(extensionsSrc);
        let copiados = 0;

        extensions.forEach(ext => {
            if (ext !== 'package.json') {
                const srcPath = path.join(extensionsSrc, ext);
                const destPath = path.join(extensionsDest, ext);

                if (fs.statSync(srcPath).isDirectory()) {
                    if (!fs.existsSync(destPath)) {
                        fs.mkdirSync(destPath, { recursive: true });
                    }
                    copyRecursive(srcPath, destPath);
                    copiados++;
                } else {
                    fs.copyFileSync(srcPath, destPath);
                    copiados++;
                }
            }
        });

        console.log(`✅ ${copiados} arquivos de extensões copiados`);
    }

} catch (error) {
    console.error('❌ Erro ao aplicar localização:', error.message);
    process.exit(1);
}

function copyRecursive(src, dest) {
    const items = fs.readdirSync(src);
    items.forEach(item => {
        const srcPath = path.join(src, item);
        const destPath = path.join(dest, item);

        if (fs.statSync(srcPath).isDirectory()) {
            if (!fs.existsSync(destPath)) {
                fs.mkdirSync(destPath, { recursive: true });
            }
            copyRecursive(srcPath, destPath);
        } else {
            fs.copyFileSync(srcPath, destPath);
        }
    });
}

console.log('\n✅ Localização pt-BR aplicada com sucesso!');
console.log(`📂 Arquivos copiados para: ${vscodeI18nPath}`);
console.log('\n🎯 Para testar: execute "npm run electron -- --locale=ptb"');