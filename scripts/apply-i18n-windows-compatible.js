// SkyCode i18n Applier (Windows Compatible)
// Aplica localização pt-BR no VS Code em tempo de build

const fs = require('fs');
const path = require('path');

console.log('🌍 Aplicando localização pt-BR no VS Code...\n');

// Caminhos
const vscodePath = path.join(__dirname, '..', 'vscode');
const i18nPath = path.join(__dirname, 'modules', 'skycode-i18n');

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
console.log('📁 i18n:', i18nPath);

// Verificar se existem traduções
const ptbPath = path.join(i18nPath, 'ptb');
if (!fs.existsSync(ptbPath)) {
    console.error('❌ Traduções pt-BR não encontradas:', ptbPath);
    process.exit(1);
}

console.log('📁 pt-BR:', ptbPath);

// Destino no VS Code
const vscodeI18nPath = path.join(vscodePath, 'i18n');
const vscodePtbPath = path.join(vscodeI18nPath, 'ptb');

console.log('\n🔧 Aplicando localização...');

try {
    // Criar diretório i18n se não existir
    if (!fs.existsSync(vscodeI18nPath)) {
        fs.mkdirSync(vscodeI18nPath, { recursive: true });
        console.log('📁 Criado diretório i18n/');
    }

    // Remover ptb anterior se existir
    if (fs.existsSync(vscodePtbPath)) {
        console.log('🗑️  Removendo localização pt-BR anterior...');
        fs.rmSync(vscodePtbPath, { recursive: true, force: true });
    }

    // Copiar traduções pt-BR
    console.log('📋 Copiando traduções pt-BR...');

    // Função simples de cópia recursiva que funciona em qualquer plataforma
    const copyRecursive = (src, dest) => {
        if (!fs.existsSync(dest)) {
            fs.mkdirSync(dest, { recursive: true });
        }

        const copy = (srcPath, destPath) => {
            const stat = fs.statSync(srcPath);
            if (stat.isDirectory()) {
                if (!fs.existsSync(destPath)) {
                    fs.mkdirSync(destPath);
                }
                const items = fs.readdirSync(srcPath);
                items.forEach(item => {
                    copy(path.join(srcPath, item), path.join(destPath, item));
                });
            } else {
                fs.copyFileSync(srcPath, destPath);
            }
        };

        const items = fs.readdirSync(src);
        items.forEach(item => {
            copy(path.join(src, item), path.join(dest, item));
        });
    };

    try {
        copyRecursive(ptbPath, vscodeI18nPath);
        console.log('✅ Traduções copiadas com método nativo');
    } catch (error) {
        console.error('   ❌ Erro na cópia:', error.message);
        process.exit(1);
    }

    // Verificar cópia
    if (fs.existsSync(path.join(vscodePtbPath, 'main.i18n.json'))) {
        const stats = fs.statSync(path.join(vscodePtbPath, 'main.i18n.json'));
        console.log(`✅ main.i18n.json copiado (${Math.round(stats.size / 1024)}KB)`);
    }

    // Funções utilitárias para substituir comandos Unix
    const findFiles = (dir, pattern, limit = 10) => {
        const results = [];

        const scan = (currentDir) => {
            try {
                const items = fs.readdirSync(currentDir);
                for (const item of items) {
                    const fullPath = path.join(currentDir, item);
                    const stat = fs.statSync(fullPath);

                    if (stat.isDirectory()) {
                        scan(fullPath);
                    } else if (pattern.test(item)) {
                        results.push(fullPath);
                        if (results.length >= limit) {
                            return;
                        }
                    }
                }
            } catch (error) {
                // Ignorar erros de permissão
            }
        };

        scan(dir);
        return results;
    };

    const countFiles = (dir) => {
        let count = 0;

        const scan = (currentDir) => {
            try {
                const items = fs.readdirSync(currentDir);
                for (const item of items) {
                    const fullPath = path.join(currentDir, item);
                    const stat = fs.statSync(fullPath);

                    if (stat.isDirectory()) {
                        scan(fullPath);
                    } else {
                        count++;
                    }
                }
            } catch (error) {
                // Ignorar erros de permissão
            }
        };

        scan(dir);
        return count;
    };

    const calculateDirSize = (dir) => {
        let totalSize = 0;

        const scan = (currentDir) => {
            try {
                const items = fs.readdirSync(currentDir);
                for (const item of items) {
                    const fullPath = path.join(currentDir, item);
                    const stat = fs.statSync(fullPath);

                    if (stat.isDirectory()) {
                        scan(fullPath);
                    } else {
                        totalSize += stat.size;
                    }
                }
            } catch (error) {
                // Ignorar erros de permissão
            }
        };

        scan(dir);

        // Formatar tamanho
        const units = ['B', 'KB', 'MB', 'GB'];
        let size = totalSize;
        let unitIndex = 0;

        while (size >= 1024 && unitIndex < units.length - 1) {
            size /= 1024;
            unitIndex++;
        }

        return `${size.toFixed(1)}${units[unitIndex]}`;
    };

    // Listar arquivos copiados (substituto para head -10)
    console.log('\n📂 Arquivos de localização:');
    const files = findFiles(vscodePtbPath, /\.json$/);
    files.slice(0, 10).forEach((file, index) => {
        const relativePath = path.relative(vscodePtbPath, file);
        console.log(`   ${index + 1}. ${relativePath}`);
    });

    if (files.length > 10) {
        console.log(`   ... e mais ${files.length - 10} arquivos`);
    }

    // Gerar resumo (substitutos para wc -l e du -sh)
    const totalFiles = countFiles(vscodePtbPath);
    const totalSize = calculateDirSize(vscodePtbPath);

    console.log('\n📊 Resumo da localização:');
    console.log(`   • Arquivos: ${totalFiles}`);
    console.log(`   • Tamanho: ${totalSize}`);
    console.log(`   • Idioma: pt-BR (Português Brasileiro)`);

} catch (error) {
    console.error('❌ Erro durante aplicação:', error.message);
    process.exit(1);
}

console.log('\n🎯 Próximos passos:');
console.log('   1. Compile o VS Code: npm run compile');
console.log('   2. Inicie com localização: npm run electron');
console.log('   3. Configure --locale=ptb nas preferências');

console.log('\n💡 Dica: Para testar localização sem modificar o fork:');
console.log('   • Use VS Code com --locale=ptb');
console.log('   • Instale extensão de idioma pt-BR');
console.log('   • Configure "locale": "ptb" em settings.json');

console.log('\n> "A localização aproxima a tecnologia do desenvolvedor" – made by Sky 🌍');