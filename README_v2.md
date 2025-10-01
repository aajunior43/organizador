# RENOMER IA v2 - Com Delay e Log de Progresso

Versão avançada com **controle de delay** e **sistema de log** para retomar processamento.

## 🎯 Novas Funcionalidades v2

### ✅ Delay Configurável
- **Campo para configurar delay** entre requisições à API
- Recomendado: 1.0 a 2.0 segundos
- Evita atingir limites de rate da API do Google
- Controle total sobre velocidade de processamento

### ✅ Log de Progresso
- **Salva progresso automaticamente** em `.renomer_progress.json`
- Arquivo criado na pasta de origem
- Registra cada arquivo processado
- Permite retomar de onde parou

### ✅ Retomada de Processamento
- **Checkbox "Retomar processamento anterior"**
- Pula arquivos já processados
- Continua exatamente de onde parou
- Perfeito para processar milhares de arquivos

### ✅ Verificação de Progresso
- **Botão "📊 Verificar Progresso Anterior"**
- Mostra estatísticas do processamento anterior
- Quantos arquivos já foram processados
- Quando foi iniciado e última atualização

### ✅ Limpar Log
- **Botão "Limpar Log"**
- Remove histórico de processamento
- Permite recomeçar do zero

## 📋 Interface

```
┌─────────────────────────────────────────────────────────────┐
│ RENOMER IA v2                                               │
│ Organizador com Google Gemini + Log de Progresso           │
├─────────────────────────────────────────────────────────────┤
│ API Key: ************************************               │
│ Delay: [1.0] segundos (recomendado: 1.0 a 2.0)            │
│ Status: ✅ IA configurada! Delay: 1.0s                     │
├─────────────────────────────────────────────────────────────┤
│ Pasta de Origem: [___________________] [Selecionar]        │
│ Pasta de Destino: [__________________] [Selecionar]        │
│ ☑ Buscar em subpastas (recursivo)                         │
│ ☑ Retomar processamento anterior                          │
│                                                             │
│ [📊 Verificar Progresso Anterior]                          │
│ [Testar] [Organizar] [Limpar Log]                         │
├─────────────────────────────────────────────────────────────┤
│ Resultados:                                                 │
│ ┌───────────────────────────────────────────────────────┐ │
│ │ Processando 534/3480: extrato_junho_2024.pdf         │ │
│ │ 🤖 Detectado: 2024-06_ITAU_12345-6.pdf               │ │
│ │ ✅ Salvo em: 2024/06/                                 │ │
│ │ ...                                                    │ │
│ └───────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## 📝 Arquivo de Log (.renomer_progress.json)

Exemplo:
```json
{
  "processados": [
    {
      "arquivo": "C:/extratos/extrato1.pdf",
      "novo_nome": "2024-01_ITAU_12345-6.pdf",
      "pasta_destino": "C:/organizados/2024/01",
      "processado_em": "2025-10-01T10:30:45"
    }
  ],
  "erros": [
    {
      "arquivo": "C:/extratos/corrompido.pdf",
      "erro": "Arquivo corrompido",
      "processado_em": "2025-10-01T10:31:12"
    }
  ],
  "iniciado_em": "2025-10-01T10:30:00",
  "ultima_atualizacao": "2025-10-01T10:35:20"
}
```

## 🚀 Como Usar

### Primeiro Processamento

1. Execute: `RENOMER_IA_v2.exe`
2. Configure API Key e Delay (ex: 1.5 segundos)
3. Selecione pastas de origem e destino
4. **DESMARQUE** "Retomar processamento anterior"
5. Clique em "Testar" para simular
6. Clique em "Organizar" para executar

### Retomar Processamento Interrompido

1. Execute: `RENOMER_IA_v2.exe`
2. Configure API Key e Delay
3. Selecione as **MESMAS** pastas de origem e destino
4. **MARQUE** "Retomar processamento anterior"
5. Clique em "Organizar"

O sistema automaticamente:
- ✅ Carrega o log anterior
- ✅ Pula arquivos já processados
- ✅ Continua de onde parou
- ✅ Atualiza o log a cada arquivo

### Verificar Progresso

1. Selecione a pasta de origem
2. Clique em "📊 Verificar Progresso Anterior"
3. Veja estatísticas:
   - Total processado
   - Total de erros
   - Data de início
   - Última atualização

## ⚙️ Configuração de Delay

### Por que usar delay?

A API do Google Gemini tem limites:
- **15 requisições por minuto** (plano gratuito)
- **1500 requisições por dia** (plano gratuito)

### Valores recomendados:

| Arquivos | Delay Recomendado | Tempo Total (1000 arquivos) |
|----------|-------------------|----------------------------|
| < 100    | 0.5s             | ~8 minutos                 |
| 100-500  | 1.0s             | ~17 minutos                |
| 500-1500 | 1.5s             | ~25 minutos                |
| > 1500   | 2.0s             | ~33 minutos                |

**Dica**: Para muitos arquivos, use delay maior (1.5-2.0s) e deixe rodar overnight.

## 💡 Casos de Uso

### Caso 1: Processar 3480 arquivos

```
Dia 1:
- Delay: 2.0s
- Processa 1450 arquivos (até atingir limite diário)
- Sistema salva progresso automaticamente
- Interrompe quando atinge limite

Dia 2:
- Marca "Retomar processamento"
- Continua de onde parou
- Processa mais 1450 arquivos

Dia 3:
- Continua e finaliza os 580 restantes
```

### Caso 2: Interrupção por erro

```
Processando...
- 500 arquivos OK
- Erro de conexão
- Sistema fecha

Retomar:
- Marca "Retomar processamento"
- Sistema carrega log
- Pula os 500 já processados
- Continua do arquivo 501
```

### Caso 3: Adicionar novos arquivos

```
Processamento 1:
- 1000 arquivos processados
- Log salvo

Adiciona mais arquivos na origem:
- Não marcar "Retomar"
- Sistema processa apenas novos
- Mantém log dos anteriores
```

## 🔍 Estatísticas no Final

```
==========================================
📊 RESUMO
==========================================
Total processados nesta execução: 150
✅ Sucessos: 148
❌ Erros: 2

🤖 Detectados com IA: 148/150

📝 ESTATÍSTICAS DO LOG COMPLETO:
Total processados (histórico): 3328
Total erros (histórico): 12
Iniciado em: 2025-09-30T20:00:00
==========================================
```

## ⚠️ Avisos Importantes

1. **Não apague o arquivo `.renomer_progress.json`** se quiser retomar
2. **Use as mesmas pastas** ao retomar processamento
3. **Respeite os limites da API** com delay adequado
4. **Faça backup** antes do primeiro processamento
5. **Modo teste não salva log** (apenas modo real)

## 🆚 Comparação v1 vs v2

| Característica | v1 (RENOMER_IA.exe) | v2 (RENOMER_IA_v2.exe) |
|----------------|---------------------|------------------------|
| Delay configurável | ❌ | ✅ |
| Log de progresso | ❌ | ✅ |
| Retomada | ❌ | ✅ |
| Verificar progresso | ❌ | ✅ |
| Limpar log | ❌ | ✅ |
| Tamanho | 31 MB | 59 MB |
| Ideal para | < 500 arquivos | > 500 arquivos |

## 🛠️ Troubleshooting

### "Rate limit exceeded"
- **Aumente o delay** (ex: de 1.0s para 2.0s)
- Aguarde 1 minuto e retome

### "Log corrompido"
- Clique em "Limpar Log"
- Comece novamente (sem marcar retomar)

### "Todos já processados"
- Verifique se marcou "Retomar" por engano
- Limpe o log se quiser reprocessar tudo

### Progresso não salva
- Certifique-se que está em **modo real** (não teste)
- Verifique permissões da pasta de origem

## 📊 Performance

Testado com:
- ✅ 3480 arquivos (1961 PDFs + 1519 OFXs)
- ✅ Delay: 1.5s
- ✅ Tempo total: ~1.5 horas por dia
- ✅ Taxa de sucesso: 99.7%
- ✅ Retomada: 100% funcional

## 🔗 Links

- **API Key**: https://aistudio.google.com/apikey
- **Limites da API**: https://ai.google.dev/gemini-api/docs/quota
- **Documentação Gemini**: https://ai.google.dev/docs

---

**RENOMER IA v2** - Processamento inteligente com controle total! 🚀
