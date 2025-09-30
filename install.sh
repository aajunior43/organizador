#!/bin/bash

# ============================================
# RENOMER - Instalador Automático (Linux/Mac)
# Sistema de Organização de Extratos Bancários
# ============================================

set -e  # Sai se houver erro

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
clear
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║        RENOMER - INSTALADOR DO SISTEMA                    ║"
echo "║        Sistema de Organização de Extratos Bancários       ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo "  Desenvolvido por: DEV ALEKSANDRO ALVES"
echo "  Versão: 2.0.0"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Função para log
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Verifica se está rodando como root
if [ "$EUID" -eq 0 ]; then
    log_warning "Não é recomendado executar como root"
    echo ""
fi

# [1/8] Verifica Python
echo -e "${BLUE}[1/8]${NC} Verificando Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    log_success "Python $PYTHON_VERSION encontrado"

    # Verifica versão mínima (3.7+)
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d'.' -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d'.' -f2)

    if [ "$PYTHON_MAJOR" -lt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 7 ]; }; then
        log_error "Python 3.7 ou superior é necessário"
        echo ""
        echo "Por favor, instale Python 3.7+:"
        echo "  Ubuntu/Debian: sudo apt install python3 python3-pip python3-venv"
        echo "  Fedora/RHEL:   sudo dnf install python3 python3-pip"
        echo "  Arch:          sudo pacman -S python python-pip"
        echo "  macOS:         brew install python3"
        exit 1
    fi
else
    log_error "Python3 não encontrado!"
    echo ""
    echo "Por favor, instale Python 3.7+:"
    echo "  Ubuntu/Debian: sudo apt install python3 python3-pip python3-venv"
    echo "  Fedora/RHEL:   sudo dnf install python3 python3-pip"
    echo "  Arch:          sudo pacman -S python python-pip"
    echo "  macOS:         brew install python3"
    exit 1
fi
echo ""

# [2/8] Verifica pip
echo -e "${BLUE}[2/8]${NC} Verificando pip..."
if python3 -m pip --version &> /dev/null; then
    log_success "pip encontrado"
else
    log_warning "pip não encontrado. Tentando instalar..."

    # Tenta instalar pip
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y python3-pip
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y python3-pip
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm python-pip
    elif command -v brew &> /dev/null; then
        brew install python3
    else
        log_error "Não foi possível instalar pip automaticamente"
        exit 1
    fi

    log_success "pip instalado"
fi
echo ""

# [3/8] Atualiza pip
echo -e "${BLUE}[3/8]${NC} Atualizando pip..."
python3 -m pip install --upgrade pip --quiet --user 2>/dev/null || true
log_success "pip atualizado"
echo ""

# [4/8] Cria ambiente virtual
echo -e "${BLUE}[4/8]${NC} Configurando ambiente virtual..."
if [ -d "venv" ]; then
    log_info "Ambiente virtual já existe"
else
    log_info "Criando ambiente virtual..."
    python3 -m venv venv
    log_success "Ambiente virtual criado"
fi
echo ""

# Ativa ambiente virtual
source venv/bin/activate
log_info "Ambiente virtual ativado"
echo ""

# [5/8] Instala dependências
echo -e "${BLUE}[5/8]${NC} Instalando dependências..."
log_info "Isso pode levar alguns minutos..."
echo ""

if [ -f "requirements.txt" ]; then
    # Instala dependências
    if pip install -r requirements.txt --quiet; then
        log_success "Todas as dependências instaladas com sucesso"
    else
        log_error "Falha ao instalar algumas dependências"
        log_info "Tentando instalar dependências essenciais..."

        # Instala dependências essenciais uma por uma
        pip install flask --quiet || true
        pip install flask-cors --quiet || true
        pip install werkzeug --quiet || true
        pip install psutil --quiet || true

        log_success "Dependências essenciais instaladas"
    fi
else
    log_error "Arquivo requirements.txt não encontrado"
    exit 1
fi
echo ""

# [6/8] Cria estrutura de diretórios
echo -e "${BLUE}[6/8]${NC} Criando estrutura de diretórios..."

mkdir -p logs
mkdir -p extratos
mkdir -p ORGANIZADO
mkdir -p relatorios/{html,json,simulacoes,organizacoes}
mkdir -p temp

log_success "Estrutura de diretórios criada"
echo ""

# [7/8] Cria scripts de execução
echo -e "${BLUE}[7/8]${NC} Criando scripts de execução..."

# Script para interface gráfica
cat > renomer-interface.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
python3 src/ui/interface_com_seletor.py
EOF
chmod +x renomer-interface.sh
log_success "Script da interface criado: ./renomer-interface.sh"

# Script para API
cat > renomer-api.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
python3 src/core/app.py
EOF
chmod +x renomer-api.sh
log_success "Script da API criado: ./renomer-api.sh"

# Script para organização local
cat > renomer-organize.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
source venv/bin/activate
python3 src/core/organizador_local_avancado.py
EOF
chmod +x renomer-organize.sh
log_success "Script de organização criado: ./renomer-organize.sh"

echo ""

# [8/8] Testa instalação
echo -e "${BLUE}[8/8]${NC} Testando instalação..."

if python3 -c "import flask; import pathlib" &> /dev/null; then
    log_success "Teste de importação bem-sucedido"
else
    log_warning "Algumas bibliotecas podem não estar instaladas corretamente"
fi
echo ""

# Resumo
echo "════════════════════════════════════════════════════════════"
echo ""
echo -e "${GREEN}✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!${NC}"
echo ""
echo "📁 Estrutura criada:"
echo "   • logs/                - Logs do sistema"
echo "   • extratos/            - Coloque seus extratos aqui"
echo "   • ORGANIZADO/          - Arquivos organizados"
echo "   • relatorios/          - Relatórios gerados"
echo ""
echo "🚀 Para iniciar o programa:"
echo "   • Interface Gráfica:   ./renomer-interface.sh"
echo "   • API Server:          ./renomer-api.sh"
echo "   • Organizar diretório: ./renomer-organize.sh"
echo ""
echo "📚 Documentação:"
echo "   • API_README.md        - Documentação da API"
echo "   • GITHUB_SETUP.md      - Instruções do GitHub"
echo ""
echo "🔧 Comandos úteis:"
echo "   • Ativar venv:         source venv/bin/activate"
echo "   • Desinstalar:         ./uninstall.sh"
echo "   • Atualizar:           git pull (se usar Git)"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Cria link simbólico (opcional)
read -p "Deseja criar link simbólico em /usr/local/bin? (s/N): " CREATE_LINK
if [[ $CREATE_LINK =~ ^[Ss]$ ]]; then
    if [ "$EUID" -eq 0 ] || sudo -v &> /dev/null; then
        INSTALL_DIR=$(pwd)

        sudo ln -sf "$INSTALL_DIR/renomer-interface.sh" /usr/local/bin/renomer 2>/dev/null || \
            log_warning "Não foi possível criar link simbólico"

        if [ -f "/usr/local/bin/renomer" ]; then
            log_success "Link criado: renomer (execute de qualquer lugar)"
        fi
    else
        log_warning "Permissões insuficientes para criar link simbólico"
    fi
    echo ""
fi

echo "Instalação completa! Pressione Enter para sair..."
read

exit 0