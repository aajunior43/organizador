# 🚀 RENOMER API - Documentação

## Visão Geral

API REST para o sistema RENOMER de organização de extratos bancários.

**Versão:** 2.0.0
**Base URL:** `http://localhost:8000/api`

## 🔒 Autenticação

Todas as requisições (exceto `/api` e `/api/health`) requerem autenticação via API Key.

**Header:**
```
X-API-Key: sua_api_key_aqui
```

**API Key Padrão (desenvolvimento):**
```
dev_key_12345
```

⚠️ **Produção:** Configure via variável de ambiente `API_KEY`

## 📊 Rate Limiting

- **Limite:** 60 requisições por minuto por IP
- **Header de resposta:** `X-Request-ID` para rastreamento
- **Erro:** 429 Too Many Requests

## 📡 Endpoints

### 1. Informações da API

```http
GET /api
```

**Resposta:**
```json
{
  "service": "RENOMER API - Bank Statement Organizer",
  "version": "2.0.0",
  "status": "running",
  "endpoints": {...},
  "authentication": "Required: X-API-Key header",
  "rate_limit": "60 requests per minute"
}
```

### 2. Health Check

```http
GET /api/health
```

**Resposta:**
```json
{
  "status": "healthy",
  "timestamp": "2025-09-30T10:00:00",
  "service": "RENOMER API",
  "version": "2.0.0",
  "uptime": 3600.0,
  "system": {
    "cpu_percent": 15.2,
    "memory_percent": 45.8
  }
}
```

### 3. Organizar Arquivos

```http
POST /api/organize
X-API-Key: dev_key_12345
Content-Type: application/json
```

**Body:**
```json
{
  "source_directory": "C:\\extratos",
  "destination_directory": "C:\\organizados",
  "test_mode": true
}
```

**Resposta:**
```json
{
  "success": true,
  "request_id": "a1b2c3d4",
  "total_arquivos": 150,
  "processados_com_sucesso": 145,
  "erros": 5,
  "detalhes": [...],
  "test_mode": true,
  "timestamp": "2025-09-30T10:00:00"
}
```

### 4. Upload de Arquivos

```http
POST /api/upload
X-API-Key: dev_key_12345
Content-Type: multipart/form-data
```

**Form Data:**
```
files: [arquivo1.pdf, arquivo2.ofx, ...]
```

**Resposta:**
```json
{
  "success": true,
  "request_id": "a1b2c3d4",
  "uploaded": 2,
  "errors": 0,
  "files": [
    {
      "filename": "extrato_junho.pdf",
      "size": 524288,
      "path": "/tmp/renomer_uploads/a1b2c3d4/extrato_junho.pdf"
    }
  ],
  "upload_directory": "/tmp/renomer_uploads/a1b2c3d4"
}
```

**Restrições:**
- Tamanho máximo: 100MB por arquivo
- Extensões permitidas: `.pdf`, `.ofx`
- Múltiplos arquivos suportados

### 5. Analisar Nome de Arquivo

```http
POST /api/analyze
X-API-Key: dev_key_12345
Content-Type: application/json
```

**Body:**
```json
{
  "filename": "EXT JUNHO 12345-6.pdf",
  "folder_context": "/extratos/2025"
}
```

**Resposta:**
```json
{
  "success": true,
  "request_id": "a1b2c3d4",
  "filename": "EXT JUNHO 12345-6.pdf",
  "data": {
    "mes": "06",
    "ano": "2025",
    "encontrado": true
  },
  "conta": {
    "numero": "123456",
    "metodo": "EXT",
    "encontrado": true
  },
  "timestamp": "2025-09-30T10:00:00"
}
```

### 6. Obter Configuração

```http
GET /api/config
X-API-Key: dev_key_12345
```

**Resposta:**
```json
{
  "success": true,
  "config": {
    "ano_padrao": "2025",
    "usar_gemini": false,
    "modo_teste_padrao": true,
    "formato_nome_arquivo": "{ano}-{mes}_{conta}_{tipo}{extensao}",
    "extensoes_suportadas": ["pdf", "ofx"]
  }
}
```

### 7. Atualizar Configuração

```http
PUT /api/config
X-API-Key: dev_key_12345
Content-Type: application/json
```

**Body:**
```json
{
  "USAR_GEMINI": false,
  "MODO_TESTE_PADRAO": true,
  "ANO_PADRAO": "2025"
}
```

**Resposta:**
```json
{
  "success": true,
  "message": "Configuration updated successfully",
  "updated_fields": ["USAR_GEMINI", "ANO_PADRAO"],
  "request_id": "a1b2c3d4"
}
```

## ⚠️ Tratamento de Erros

### Códigos de Status HTTP

| Código | Significado |
|--------|-------------|
| 200 | Sucesso |
| 400 | Bad Request - Validação falhou |
| 401 | Unauthorized - API Key não fornecida |
| 403 | Forbidden - API Key inválida |
| 404 | Not Found - Endpoint não existe |
| 405 | Method Not Allowed |
| 429 | Too Many Requests - Rate limit excedido |
| 500 | Internal Server Error |

### Formato de Erro

```json
{
  "success": false,
  "error": "Invalid API key",
  "message": "Detalhes adicionais do erro",
  "request_id": "a1b2c3d4"
}
```

## 🔧 Configuração e Deploy

### Desenvolvimento

```bash
# Instalar dependências
pip install -r requirements.txt

# Executar servidor
python src/core/app.py
```

### Produção (Linux/Mac)

```bash
# Com Gunicorn (recomendado)
gunicorn -w 4 -b 0.0.0.0:8000 src.core.app:app

# Com workers e timeout
gunicorn -w 4 -b 0.0.0.0:8000 --timeout 300 src.core.app:app
```

### Produção (Windows)

```bash
# Com Waitress
waitress-serve --host=0.0.0.0 --port=8000 src.core.app:app
```

### Variáveis de Ambiente

```bash
# Segurança
export API_KEY="sua_chave_secreta_aqui"
export SECRET_KEY="secret_key_para_flask"
export ALLOWED_ORIGINS="https://seu-dominio.com"

# Debug (apenas desenvolvimento)
export DEBUG="true"
```

## 📝 Exemplos de Uso

### cURL

```bash
# Health check
curl http://localhost:8000/api/health

# Organizar arquivos
curl -X POST http://localhost:8000/api/organize \
  -H "X-API-Key: dev_key_12345" \
  -H "Content-Type: application/json" \
  -d '{
    "source_directory": "C:\\extratos",
    "destination_directory": "C:\\organizados",
    "test_mode": true
  }'

# Upload de arquivo
curl -X POST http://localhost:8000/api/upload \
  -H "X-API-Key: dev_key_12345" \
  -F "files=@extrato.pdf"
```

### Python

```python
import requests

API_URL = "http://localhost:8000/api"
API_KEY = "dev_key_12345"

headers = {
    "X-API-Key": API_KEY,
    "Content-Type": "application/json"
}

# Organizar arquivos
response = requests.post(
    f"{API_URL}/organize",
    headers=headers,
    json={
        "source_directory": "C:\\extratos",
        "destination_directory": "C:\\organizados",
        "test_mode": True
    }
)

print(response.json())

# Upload de arquivo
with open("extrato.pdf", "rb") as f:
    files = {"files": f}
    response = requests.post(
        f"{API_URL}/upload",
        headers={"X-API-Key": API_KEY},
        files=files
    )

print(response.json())
```

### JavaScript (Fetch)

```javascript
const API_URL = "http://localhost:8000/api";
const API_KEY = "dev_key_12345";

// Organizar arquivos
async function organizeFiles() {
  const response = await fetch(`${API_URL}/organize`, {
    method: "POST",
    headers: {
      "X-API-Key": API_KEY,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      source_directory: "C:\\extratos",
      destination_directory: "C:\\organizados",
      test_mode: true
    })
  });

  const data = await response.json();
  console.log(data);
}

// Upload de arquivo
async function uploadFile(file) {
  const formData = new FormData();
  formData.append("files", file);

  const response = await fetch(`${API_URL}/upload`, {
    method: "POST",
    headers: {
      "X-API-Key": API_KEY
    },
    body: formData
  });

  const data = await response.json();
  console.log(data);
}
```

## 🛡️ Segurança

### Boas Práticas

1. **API Keys:**
   - Nunca exponha API keys em código
   - Use variáveis de ambiente
   - Rotacione keys regularmente
   - Uma key por aplicação/usuário

2. **CORS:**
   - Configure `ALLOWED_ORIGINS` para seus domínios específicos
   - Nunca use `*` em produção

3. **HTTPS:**
   - Sempre use HTTPS em produção
   - Configure certificados SSL/TLS

4. **Rate Limiting:**
   - Ajuste limites conforme sua necessidade
   - Monitore logs para detectar abusos

5. **Validação:**
   - Todos os inputs são validados
   - Path traversal protegido
   - Tamanhos de arquivo limitados

## 📊 Logging

Logs são salvos em `logs/api.log` com rotação automática.

**Formato:**
```
2025-09-30 10:00:00 - app - INFO - [a1b2c3d4] - POST /api/organize - Status: 200 - Duration: 1.234s
```

## 🤝 Suporte

- **Desenvolvedor:** DEV ALEKSANDRO ALVES
- **Repositório:** [GitHub](https://github.com/SEU_USUARIO/RENOMER)

---

**Versão:** 2.0.0
**Última atualização:** 2025-09-30