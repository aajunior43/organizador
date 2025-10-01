# RENOMER IA - Organizador de Extratos com Inteligência Artificial

Organizador automático de extratos bancários usando **Google Gemini AI** para detectar banco, conta, mês e ano.

## 🎯 Características

- ✅ **100% IA**: Usa Google Gemini para detectar todas as informações
- ✅ **Sem regras fixas**: A IA entende o contexto do arquivo
- ✅ **Multi-formato**: PDF e OFX
- ✅ **Busca recursiva**: Procura em subpastas
- ✅ **Interface gráfica**: Fácil de usar
- ✅ **Portátil**: Executável único (31 MB)

## 📋 Como Usar

### 1. Obter API Key do Google Gemini

1. Acesse: https://aistudio.google.com/apikey
2. Faça login com sua conta Google
3. Clique em "Create API Key"
4. Copie a chave gerada

**É GRATUITO!** O Google oferece:
- 15 requisições por minuto
- 1500 requisições por dia
- Sem custo

### 2. Executar o RENOMER_IA

1. Execute: `RENOMER_IA.exe`
2. Cole sua API key no campo "Google Gemini API Key"
3. Clique em "Configurar"
4. Aguarde a mensagem: ✅ IA configurada e pronta!

### 3. Organizar Arquivos

1. Clique em "Selecionar" na **Pasta de Origem** (onde estão seus extratos)
2. Clique em "Selecionar" na **Pasta de Destino** (onde organizar)
3. Marque/desmarque "Buscar em subpastas (recursivo)"
4. Clique em "Testar (Simulação)" para ver o que será feito
5. Clique em "Organizar (Real)" para executar

## 📁 Estrutura de Organização

Os arquivos são organizados em:

```
Pasta Destino/
├── 2024/
│   ├── 01/
│   │   ├── 2024-01_ITAU_12345-6.pdf
│   │   └── 2024-01_NUBANK_67890-1.ofx
│   ├── 02/
│   │   └── 2024-02_BRADESCO_11111-2.pdf
│   └── ...
└── 2025/
    ├── 01/
    └── ...
```

## 🤖 Como a IA Funciona

A IA analisa:
1. **Nome do arquivo**
2. **Conteúdo do arquivo** (primeiras páginas/linhas)

E extrai:
- **Banco**: ITAU, BRADESCO, SANTANDER, BB, CAIXA, NUBANK, INTER, C6, BTG, etc.
- **Conta**: Número da conta (ex: 12345-6)
- **Mês**: 01 a 12
- **Ano**: 2024, 2025, etc.

## 💡 Vantagens da IA

✅ **Detecta formatos variados**: A IA entende diferentes layouts de extratos
✅ **Sem manutenção**: Não precisa atualizar regras quando bancos mudam formato
✅ **Inteligente**: Entende contexto e abreviações
✅ **Preciso**: Usa informações do conteúdo, não apenas do nome

## 🔒 Privacidade

- ⚠️ **Cuidado**: A IA envia trechos do arquivo para o Google Gemini
- 📄 São enviados apenas os primeiros 2000-3000 caracteres
- 🔐 Use apenas se você confia no Google com seus dados
- 💼 Para dados sensíveis, use a versão sem IA: `RENOMER.exe`

## 🆚 Comparação

| Característica | RENOMER_IA.exe | RENOMER.exe |
|----------------|----------------|-------------|
| Detecção | IA (Gemini) | Regras/Regex |
| Precisão | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Privacidade | Envia dados | Local 100% |
| Requer Internet | Sim | Não |
| Requer API key | Sim | Não |
| Custo | Gratuito* | Gratuito |
| Tamanho | 31 MB | 29 MB |

*Dentro dos limites gratuitos do Google

## ⚙️ Requisitos

- Windows 10/11
- Conexão com Internet
- API Key do Google Gemini (gratuita)

## 🐛 Troubleshooting

### "IA não configurada"
- Verifique se colou a API key corretamente
- Teste sua API key em: https://aistudio.google.com/

### "Erro ao configurar IA"
- Verifique sua conexão com Internet
- Aguarde 1 minuto e tente novamente
- Gere uma nova API key

### "Nenhum arquivo encontrado"
- Marque a opção "Buscar em subpastas"
- Verifique se há arquivos PDF ou OFX na pasta
- Verifique as permissões da pasta

## 📊 Estatísticas

Após organizar, você verá:
- 📋 Total de arquivos processados
- ✅ Sucessos e ❌ Erros
- 🤖 Quantos foram detectados com IA
- 📄 Lista detalhada dos primeiros 50 arquivos

## 🎓 Dicas

1. **Teste primeiro**: Use "Testar (Simulação)" antes de organizar
2. **API Key**: Guarde sua API key em local seguro
3. **Subpastas**: Marque "recursivo" se tem arquivos em subpastas
4. **Backup**: Faça backup antes de organizar pela primeira vez
5. **Limites**: Respeite os limites gratuitos (1500 requisições/dia)

## 📝 Formato do Nome

Os arquivos são renomeados para:

```
AAAA-MM_BANCO_CONTA.extensao
```

Exemplos:
- `2024-01_ITAU_12345-6.pdf`
- `2025-03_NUBANK_67890-1.ofx`
- `2024-12_SANTANDER.pdf` (se não detectar conta)

## 🔗 Links Úteis

- **API Key**: https://aistudio.google.com/apikey
- **Google Gemini**: https://ai.google.dev/
- **Documentação**: https://ai.google.dev/docs

---

**Desenvolvido com ❤️ usando Google Gemini AI**
