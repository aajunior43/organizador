# 📦 Guia de Instalação - RENOMER

## Sistema de Organização de Extratos Bancários

**Versão:** 2.0.0
**Desenvolvido por:** DEV ALEKSANDRO ALVES

---

## 📋 Índice

- [Requisitos do Sistema](#requisitos-do-sistema)
- [Instalação Windows](#instalação-windows)
- [Instalação Linux/Mac](#instalação-linuxmac)
- [Instalação Manual](#instalação-manual)
- [Verificação da Instalação](#verificação-da-instalação)
- [Desinstalação](#desinstalação)
- [Solução de Problemas](#solução-de-problemas)

---

## 🖥️ Requisitos do Sistema

### Requisitos Mínimos

| Componente | Requisito |
|------------|-----------|
| **Sistema Operacional** | Windows 7+, Linux, macOS 10.12+ |
| **Python** | 3.7 ou superior |
| **RAM** | 2GB mínimo (4GB recomendado) |
| **Espaço em Disco** | 500MB para instalação + espaço para dados |
| **Processador** | Dual-core 1.5 GHz ou superior |

### Requisitos de Software

- Python 3.7+ com pip
- Tkinter (geralmente incluído com Python)
- Git (opcional, para atualização via GitHub)

---

## 🪟 Instalação Windows

### Método 1: Instalação Automática (Recomendado)

1. **Baixe o projeto:**
   ```bash
   git clone https://github.com/aajunior43/organizador.git
   cd organizador
   ```

   Ou baixe o ZIP e extraia.

2. **Execute o instalador:**
   - Clique duas vezes em `install.bat`
   - Ou via CMD/PowerShell:
     ```cmd
     install.bat
     ```

3. **Siga as instruções na tela:**
   - O instalador verificará Python
   - Instalará dependências automaticamente
   - Criará estrutura de diretórios
   - Gerará atalhos de execução

4. **Pronto!** Use os atalhos criados:
   - `RENOMER_Interface.bat` - Interface gráfica
   - `RENOMER_API.bat` - Servidor API

### Método 2: Instalação Manual

```cmd
# 1. Verificar Python
python --version

# 2. Criar ambiente virtual
python -m venv venv

# 3. Ativar ambiente virtual
venv\Scripts\activate

# 4. Instalar dependências
pip install -r requirements.txt

# 5. Criar diretórios
mkdir logs extratos ORGANIZADO relatorios

# 6. Executar
python src\ui\interface_com_seletor.py
```

---

## 🐧 Instalação Linux/Mac

### Método 1: Instalação Automática (Recomendado)

1. **Baixe o projeto:**
   ```bash
   git clone https://github.com/aajunior43/organizador.git
   cd organizador
   ```

2. **Torne o instalador executável:**
   ```bash
   chmod +x install.sh
   ```

3. **Execute o instalador:**
   ```bash
   ./install.sh
   ```

4. **Siga as instruções na tela.**

5. **Pronto!** Use os scripts criados:
   ```bash
   ./renomer-interface.sh   # Interface gráfica
   ./renomer-api.sh         # Servidor API
   ./renomer-organize.sh    # Organização via CLI
   ```

### Método 2: Instalação Manual

```bash
# 1. Verificar Python
python3 --version

# 2. Instalar dependências do sistema (Ubuntu/Debian)
sudo apt install python3 python3-pip python3-venv python3-tk

# 3. Criar ambiente virtual
python3 -m venv venv

# 4. Ativar ambiente virtual
source venv/bin/activate

# 5. Instalar dependências Python
pip install -r requirements.txt

# 6. Criar diretórios
mkdir -p logs extratos ORGANIZADO relatorios/{html,json,simulacoes,organizacoes}

# 7. Executar
python3 src/ui/interface_com_seletor.py
```

### Criando Link Simbólico (Opcional)

Para executar de qualquer lugar:

```bash
sudo ln -s $(pwd)/renomer-interface.sh /usr/local/bin/renomer
```

Agora você pode executar apenas com:
```bash
renomer
```

---

## 🔧 Instalação Manual

### Passo a Passo Detalhado

#### 1. Instalar Python

**Windows:**
- Baixe de [python.org](https://www.python.org/downloads/)
- Durante instalação, marque "Add Python to PATH"
- Instale com opções padrão

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip python3-venv python3-tk

# Fedora/RHEL
sudo dnf install python3 python3-pip python3-tkinter

# Arch
sudo pacman -S python python-pip tk
```

**macOS:**
```bash
# Com Homebrew
brew install python@3.11

# Ou baixe de python.org
```

#### 2. Baixar o Projeto

**Via Git:**
```bash
git clone https://github.com/aajunior43/organizador.git
cd organizador
```

**Ou baixar ZIP:**
1. Acesse https://github.com/aajunior43/organizador
2. Clique em "Code" → "Download ZIP"
3. Extraia para uma pasta

#### 3. Criar Ambiente Virtual

```bash
# Windows
python -m venv venv

# Linux/Mac
python3 -m venv venv
```

#### 4. Ativar Ambiente Virtual

```bash
# Windows CMD
venv\Scripts\activate.bat

# Windows PowerShell
venv\Scripts\Activate.ps1

# Linux/Mac
source venv/bin/activate
```

#### 5. Instalar Dependências

```bash
pip install -r requirements.txt
```

#### 6. Criar Estrutura de Diretórios

```bash
# Windows
mkdir logs extratos ORGANIZADO relatorios

# Linux/Mac
mkdir -p logs extratos ORGANIZADO relatorios/{html,json,simulacoes,organizacoes}
```

#### 7. Testar Instalação

```bash
# Interface gráfica
python src/ui/interface_com_seletor.py

# API
python src/core/app.py

# Organização local
python src/core/organizador_local_avancado.py
```

---

## ✅ Verificação da Instalação

### Teste Rápido

Execute no terminal (com ambiente virtual ativado):

```python
python -c "import flask; import tkinter; print('✅ Instalação OK!')"
```

### Verificação Completa

1. **Testar Interface Gráfica:**
   ```bash
   python src/ui/interface_com_seletor.py
   ```
   - Deve abrir janela gráfica
   - Verifique se botões respondem

2. **Testar API:**
   ```bash
   python src/core/app.py
   ```
   - Acesse http://localhost:8000/api
   - Deve mostrar documentação da API

3. **Verificar Estrutura:**
   ```bash
   # Windows
   dir logs extratos ORGANIZADO

   # Linux/Mac
   ls -la logs extratos ORGANIZADO
   ```

---

## 🗑️ Desinstalação

### Windows

**Método Automático:**
```cmd
uninstall.bat
```

**Opções disponíveis:**
1. Remover apenas ambiente virtual e dependências
2. Remover ambiente + logs e temporários
3. Remover TUDO (incluindo dados)

**Método Manual:**
```cmd
# Desativar ambiente virtual
deactivate

# Remover ambiente virtual
rmdir /s /q venv

# Remover cache Python
del /s /q *.pyc
for /d /r %d in (__pycache__) do @if exist "%d" rd /s /q "%d"

# Remover logs
rmdir /s /q logs
```

### Linux/Mac

**Método Automático:**
```bash
./uninstall.sh
```

**Método Manual:**
```bash
# Desativar ambiente virtual
deactivate

# Remover ambiente virtual
rm -rf venv

# Remover cache Python
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type f -name "*.pyc" -delete

# Remover logs
rm -rf logs

# Remover scripts
rm -f renomer-*.sh

# Remover link simbólico (se criado)
sudo rm -f /usr/local/bin/renomer
```

---

## 🔍 Solução de Problemas

### Problema: "Python não encontrado"

**Solução:**
1. Verifique se Python está instalado: `python --version` ou `python3 --version`
2. Se não estiver, instale de [python.org](https://www.python.org/downloads/)
3. No Windows, adicione Python ao PATH
4. Reinicie o terminal após instalação

### Problema: "pip não encontrado"

**Solução:**
```bash
# Windows
python -m ensurepip --default-pip

# Linux/Mac
sudo apt install python3-pip  # Ubuntu/Debian
```

### Problema: "Tkinter não encontrado"

**Solução:**
```bash
# Ubuntu/Debian
sudo apt install python3-tk

# Fedora/RHEL
sudo dnf install python3-tkinter

# Arch
sudo pacman -S tk

# macOS (já incluído geralmente)
```

### Problema: "Permissão negada" (Linux/Mac)

**Solução:**
```bash
# Torne scripts executáveis
chmod +x install.sh uninstall.sh
chmod +x renomer-*.sh
```

### Problema: Erro ao instalar dependências

**Solução:**
```bash
# Atualizar pip primeiro
pip install --upgrade pip

# Instalar dependências uma por uma
pip install flask
pip install flask-cors
pip install werkzeug
pip install psutil

# Ou com --user
pip install --user -r requirements.txt
```

### Problema: Interface gráfica não abre

**Solução:**
1. Verifique se Tkinter está instalado
2. Verifique variável DISPLAY (Linux):
   ```bash
   echo $DISPLAY
   export DISPLAY=:0
   ```
3. Use XQuartz no macOS se necessário

### Problema: API não inicia

**Solução:**
1. Verifique se porta 8000 está livre:
   ```bash
   # Windows
   netstat -an | find "8000"

   # Linux/Mac
   netstat -an | grep 8000
   ```
2. Mude a porta se necessário no código
3. Verifique firewall

### Problema: Erro de memória

**Solução:**
1. Feche outros programas
2. Processe menos arquivos por vez
3. Aumente memória virtual (swap)

---

## 📞 Suporte

### Precisa de Ajuda?

- **Issues GitHub:** https://github.com/aajunior43/organizador/issues
- **Documentação API:** Veja [API_README.md](API_README.md)
- **Email:** [seu-email]

### Informações para Reportar Bugs

Ao reportar problemas, inclua:
- Sistema operacional e versão
- Versão do Python (`python --version`)
- Log de erro completo
- Passos para reproduzir

---

## 📝 Notas Adicionais

### Atualizando o RENOMER

**Via Git:**
```bash
git pull origin master
pip install -r requirements.txt
```

**Manual:**
1. Baixe nova versão
2. Extraia sobre arquivos existentes
3. Execute `pip install -r requirements.txt`

### Backup de Dados

Antes de atualizar ou desinstalar, faça backup de:
- Pasta `ORGANIZADO/`
- Pasta `extratos/`
- Pasta `relatorios/`
- Arquivo `config/config.py` (se modificado)

### Ambiente Virtual

**Ativar:**
```bash
# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate
```

**Desativar:**
```bash
deactivate
```

---

**Última atualização:** 2025-09-30
**Versão do documento:** 1.0