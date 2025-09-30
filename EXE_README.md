# 📦 RENOMER - Executáveis Windows

## Arquivos Disponíveis

### ✅ RENOMER_Portable.exe (11 MB) - **RECOMENDADO**
- **Arquivo único** - Tudo em um só executável
- **Portátil** - Pode ser copiado para qualquer pasta
- **Sem instalação** - Apenas execute
- **Tamanho:** ~11 MB

### 📁 RENOMER (Pasta com executável)
- **Múltiplos arquivos** - Executável + DLLs separadas
- **Menor EXE** - RENOMER.exe tem ~2 MB
- **Bibliotecas separadas** - Pasta `_internal` com dependências
- **Total:** ~15 MB

---

## 🚀 Como Usar

### Opção 1: RENOMER_Portable.exe (Mais Fácil)

1. **Copie** `RENOMER_Portable.exe` para qualquer pasta
2. **Execute** com duplo clique
3. **Pronto!** A interface abrirá

### Opção 2: Pasta RENOMER

1. **Copie** toda a pasta `dist\RENOMER` para onde quiser
2. **Execute** `RENOMER.exe` dentro da pasta
3. **Não separe** o .exe da pasta `_internal`

---

## 📋 Primeira Execução

### Windows Defender Pode Alertar

É normal! O Windows não reconhece o executável. Para permitir:

1. Clique em "Mais informações"
2. Clique em "Executar assim mesmo"
3. Ou adicione exceção no Windows Defender

### Estrutura Automática

Na primeira execução, serão criadas as pastas:
- `logs/` - Logs do sistema
- `extratos/` - Coloque seus extratos aqui
- `ORGANIZADO/` - Arquivos organizados aparecerão aqui
- `relatorios/` - Relatórios HTML gerados

---

## 💡 Funcionalidades

### Interface Gráfica Completa
- ✅ Seleção de pastas com diálogo visual
- ✅ Simulação antes de organizar
- ✅ Barra de progresso em tempo real
- ✅ Log de operações
- ✅ Relatórios HTML automáticos

### Detecção Automática
- ✅ **Datas:** 06/2023, JUN/2023, JUNHO, 202306, etc
- ✅ **Contas:** 12345-6, Extrato123456, EXT JUNHO 12345-X
- ✅ **Estrutura:** CONTA_123456/2023_06_JUNHO/

### Segurança
- ✅ Arquivos são **COPIADOS** (originais preservados)
- ✅ Validação de operações
- ✅ Confirmação antes de executar
- ✅ Logs completos

---

## 🎯 Passo a Passo

### 1. Preparar Extratos
```
Coloque seus arquivos .pdf e .ofx em uma pasta
Exemplo: C:\Meus_Extratos\
```

### 2. Executar RENOMER
```
Duplo clique em RENOMER_Portable.exe
```

### 3. Selecionar Pastas
```
- Pasta de Origem: C:\Meus_Extratos\
- Pasta de Destino: C:\Extratos_Organizados\
```

### 4. Simular (Recomendado)
```
Clique em "🔍 SIMULAR E VER ESTATÍSTICAS"
- Veja quantos arquivos serão processados
- Identifique problemas
- Relatório HTML abre automaticamente
```

### 5. Organizar
```
Clique em "✅ ORGANIZAR EXTRATOS"
- Confirme a operação
- Aguarde o processamento
- Pasta de destino abre automaticamente
```

---

## 📊 Exemplo de Saída

### Antes:
```
Extratos/
├── EXT JUNHO 12345-6.pdf
├── JULHO 2023 12345-6.pdf
├── Extrato123456.ofx
└── 08-2023 AGOSTO 12345-6.pdf
```

### Depois:
```
ORGANIZADO/
├── CONTA_123456/
│   ├── 2023_06_JUNHO/
│   │   └── 2023-06_123456_PDF.pdf
│   ├── 2023_07_JULHO/
│   │   └── 2023-07_123456_PDF.pdf
│   └── 2023_08_AGOSTO/
│       └── 2023-08_123456_PDF.pdf
└── CONTA_123456/
    └── 2023_06_JUNHO/
        └── 2023-06_123456_OFX.ofx
```

---

## ❓ Perguntas Frequentes

### O executável é seguro?
✅ Sim! É o próprio código Python empacotado.
- Código-fonte disponível em: https://github.com/aajunior43/organizador
- Sem vírus, sem malware
- Windows Defender pode alertar por ser desconhecido

### Preciso ter Python instalado?
❌ Não! O executável já inclui tudo necessário.

### Funciona offline?
✅ Sim! Não precisa de internet.

### Qual a diferença entre Portable e pasta?
- **Portable:** Arquivo único, mais fácil de usar
- **Pasta:** Vários arquivos, inicialização mais rápida

### Onde ficam os logs?
- Pasta `logs/` ao lado do executável
- Arquivo: `organizador_local.log`

### Como desinstalar?
- Apenas delete o arquivo .exe
- Delete as pastas criadas se quiser

### Posso copiar para pen drive?
✅ Sim! RENOMER_Portable.exe é totalmente portátil.

### Funciona no Windows 7?
✅ Sim! Windows 7, 8, 10 e 11.

---

## 🔧 Solução de Problemas

### "Windows protegeu seu computador"
**Causa:** Executável não reconhecido pelo Windows
**Solução:**
1. Clique em "Mais informações"
2. Clique em "Executar assim mesmo"

### "Não foi possível iniciar"
**Causa:** Falta de permissões
**Solução:**
1. Clique direito no .exe
2. "Executar como administrador"

### Interface não abre
**Causa:** Possível conflito com antivírus
**Solução:**
1. Adicione exceção no antivírus
2. Ou use instalação via Python (install.bat)

### Erro ao processar arquivos
**Causa:** Permissões nas pastas
**Solução:**
1. Verifique permissões de leitura/escrita
2. Não use pastas do sistema (C:\Windows, etc)

### Trava durante processamento
**Causa:** Muitos arquivos
**Solução:**
1. Processe em lotes menores
2. Feche outros programas

---

## 📱 Requisitos

| Item | Requisito |
|------|-----------|
| Sistema | Windows 7 ou superior |
| RAM | 2GB mínimo |
| Espaço | 50MB para executável + espaço para dados |
| Processador | Qualquer processador moderno |
| Internet | Não necessário |
| Python | Não necessário |

---

## 🎁 Recursos Incluídos

### Executável Inclui:
- ✅ Python 3.13
- ✅ Tkinter (interface gráfica)
- ✅ Todas as bibliotecas necessárias
- ✅ Sistema de detecção inteligente
- ✅ Gerador de relatórios
- ✅ Sistema de cache
- ✅ Validações de segurança

### O Que NÃO Está Incluído:
- ❌ Editor de PDF
- ❌ Leitor de OFX (mas organiza os arquivos)
- ❌ Servidor API (use versão Python)

---

## 📦 Distribuição

### Para Compartilhar:

**Opção 1: Portable**
```
1. Copie RENOMER_Portable.exe
2. Envie por email/drive/pendrive
3. Destinatário apenas executa
```

**Opção 2: Completa**
```
1. Comprima pasta dist\RENOMER em ZIP
2. Compartilhe o ZIP
3. Destinatário extrai e executa RENOMER.exe
```

**Opção 3: Instalador Automático**
```
1. Compartilhe install.bat do repositório
2. Requer Python instalado
3. Instala ambiente completo
```

---

## 🔄 Atualizações

Para atualizar:
1. Baixe nova versão do executável
2. Substitua o arquivo antigo
3. Suas configurações serão mantidas

Ou baixe do GitHub:
```
https://github.com/aajunior43/organizador
```

---

## 🆘 Suporte

### Problemas?
- **GitHub Issues:** https://github.com/aajunior43/organizador/issues
- **Documentação:** Veja INSTALL_GUIDE.md
- **API:** Veja API_README.md

### Informações para Bug Report:
- Versão do Windows
- Mensagem de erro completa
- Arquivo de log (logs/organizador_local.log)
- Passos para reproduzir

---

## 📝 Notas Técnicas

### Tecnologias Utilizadas:
- Python 3.13
- PyInstaller 6.15
- Tkinter
- Regex avançado
- Sistema de cache MD5

### Tamanhos dos Arquivos:
- RENOMER_Portable.exe: ~11 MB
- RENOMER.exe: ~2 MB (+ ~13 MB de DLLs)
- Descompactado: ~15-20 MB

### Performance:
- Inicia em: 2-5 segundos
- Processa: ~100 arquivos/minuto
- Memória: ~50-100 MB durante uso

---

## 👨‍💻 Desenvolvedor

**DEV ALEKSANDRO ALVES**

- GitHub: https://github.com/aajunior43/organizador
- Versão: 2.0.0
- Data: 2025-09-30

---

## 📄 Licença

Este software é fornecido "como está", sem garantias.
Use por sua própria conta e risco.

**Código aberto disponível no GitHub!**

---

**🎉 Obrigado por usar o RENOMER!**

*Sistema de Organização de Extratos Bancários*