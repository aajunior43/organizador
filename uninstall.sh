#!/bin/bash

# ============================================
# RENOMER - Desinstalador (Linux/Mac)
# Sistema de Organização de Extratos Bancários
# ============================================

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
clear
echo -e "${RED}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║        RENOMER - DESINSTALADOR                            ║"
echo "║        Sistema de Organização de Extratos Bancários       ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo "  Desenvolvido por: DEV ALEKSANDRO ALVES"
echo "  Versão: 2.0.0"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo -e "${YELLOW}⚠️  ATENÇÃO: Este script irá remover componentes do RENOMER${NC}"
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

# Confirmação
read -p "Deseja realmente desinstalar o RENOMER? (s/N): " CONFIRM
if [[ ! $CONFIRM =~ ^[Ss]$ ]]; then
    log_info "Desinstalação cancelada pelo usuário"
    exit 0
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Opções de desinstalação
echo "O que deseja remover?"
echo ""
echo "[1] Apenas ambiente virtual e dependências (Recomendado)"
echo "[2] Ambiente virtual + arquivos temporários e logs"
echo "[3] TUDO (incluindo extratos e arquivos organizados)"
echo "[4] Cancelar"
echo ""
read -p "Escolha uma opção (1-4): " UNINSTALL_TYPE

if [ "$UNINSTALL_TYPE" == "4" ]; then
    log_info "Desinstalação cancelada"
    exit 0
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
log_info "Iniciando desinstalação..."
echo ""

ITEMS_REMOVED=0

# Opção 1, 2 ou 3: Remove ambiente virtual
if [ "$UNINSTALL_TYPE" -ge 1 ]; then
    echo -e "${BLUE}[1/7]${NC} Removendo ambiente virtual..."
    if [ -d "venv" ]; then
        rm -rf venv
        log_success "Ambiente virtual removido"
        ((ITEMS_REMOVED++))
    else
        log_info "Ambiente virtual não encontrado"
    fi
    echo ""
fi

# Opção 1, 2 ou 3: Remove cache Python
if [ "$UNINSTALL_TYPE" -ge 1 ]; then
    echo -e "${BLUE}[2/7]${NC} Removendo cache Python..."

    # Remove __pycache__
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

    # Remove .pyc
    find . -type f -name "*.pyc" -delete 2>/dev/null || true

    # Remove .pyo
    find . -type f -name "*.pyo" -delete 2>/dev/null || true

    log_success "Cache Python removido"
    ((ITEMS_REMOVED++))
    echo ""
fi

# Opção 2 ou 3: Remove logs
if [ "$UNINSTALL_TYPE" -ge 2 ]; then
    echo -e "${BLUE}[3/7]${NC} Removendo logs..."
    if [ -d "logs" ]; then
        rm -rf logs
        log_success "Logs removidos"
        ((ITEMS_REMOVED++))
    else
        log_info "Pasta de logs não encontrada"
    fi
    echo ""
fi

# Opção 2 ou 3: Remove arquivos temporários
if [ "$UNINSTALL_TYPE" -ge 2 ]; then
    echo -e "${BLUE}[4/7]${NC} Removendo arquivos temporários..."

    [ -d "temp" ] && rm -rf temp && log_success "Pasta temp removida" && ((ITEMS_REMOVED++))
    [ -f "interface_config.json" ] && rm -f interface_config.json && log_success "Configuração da interface removida" && ((ITEMS_REMOVED++))
    find . -maxdepth 1 -name "*.log" -delete 2>/dev/null && log_success "Arquivos .log removidos"

    log_success "Arquivos temporários removidos"
    echo ""
fi

# Opção 3: Remove TUDO
if [ "$UNINSTALL_TYPE" == "3" ]; then
    echo -e "${BLUE}[5/7]${NC} Removendo extratos e arquivos organizados..."
    echo ""
    echo -e "${RED}⚠️  AVISO: Você está prestes a DELETAR TODOS OS ARQUIVOS!${NC}"
    echo "     Isso inclui extratos e arquivos organizados."
    echo ""
    read -p "Tem certeza ABSOLUTA? Digite 'SIM' para confirmar: " CONFIRM_DELETE

    if [ "$CONFIRM_DELETE" == "SIM" ]; then
        [ -d "extratos" ] && rm -rf extratos && log_success "Pasta extratos removida" && ((ITEMS_REMOVED++))
        [ -d "ORGANIZADO" ] && rm -rf ORGANIZADO && log_success "Pasta ORGANIZADO removida" && ((ITEMS_REMOVED++))
        [ -d "resultado_organizacao" ] && rm -rf resultado_organizacao && log_success "Pasta resultado_organizacao removida" && ((ITEMS_REMOVED++))
        [ -d "relatorios" ] && rm -rf relatorios && log_success "Pasta relatorios removida" && ((ITEMS_REMOVED++))

        log_success "Todos os arquivos de dados removidos"
    else
        log_info "Remoção de dados cancelada"
    fi
    echo ""
fi

# Remove scripts de execução
echo -e "${BLUE}[6/7]${NC} Removendo scripts de execução..."

[ -f "renomer-interface.sh" ] && rm -f renomer-interface.sh && log_success "renomer-interface.sh removido" && ((ITEMS_REMOVED++))
[ -f "renomer-api.sh" ] && rm -f renomer-api.sh && log_success "renomer-api.sh removido" && ((ITEMS_REMOVED++))
[ -f "renomer-organize.sh" ] && rm -f renomer-organize.sh && log_success "renomer-organize.sh removido" && ((ITEMS_REMOVED++))

# Remove link simbólico
if [ -L "/usr/local/bin/renomer" ]; then
    if sudo rm -f /usr/local/bin/renomer 2>/dev/null; then
        log_success "Link simbólico removido"
        ((ITEMS_REMOVED++))
    fi
fi

echo ""

# Limpeza final
echo -e "${BLUE}[7/7]${NC} Limpeza final..."

[ -f "nul" ] && rm -f nul

log_success "Limpeza concluída"
echo ""

# Resumo
echo "════════════════════════════════════════════════════════════"
echo ""
echo -e "${GREEN}✅ DESINSTALAÇÃO CONCLUÍDA!${NC}"
echo ""
echo "📊 Resumo:"
echo "   • Itens removidos: $ITEMS_REMOVED"
echo "   • Tipo de desinstalação: Opção $UNINSTALL_TYPE"
echo ""

case $UNINSTALL_TYPE in
    1)
        echo "📝 Arquivos mantidos:"
        echo "   • Código fonte do programa"
        echo "   • Extratos e arquivos organizados"
        echo "   • Configurações"
        echo "   • Logs"
        echo ""
        echo "💡 Para reinstalar: ./install.sh"
        ;;
    2)
        echo "📝 Arquivos mantidos:"
        echo "   • Código fonte do programa"
        echo "   • Extratos e arquivos organizados"
        echo ""
        echo "💡 Para reinstalar: ./install.sh"
        ;;
    3)
        echo "📝 Arquivos mantidos:"
        echo "   • Código fonte do programa"
        echo "   • Documentação"
        echo ""
        echo -e "${YELLOW}⚠️  Todos os dados foram removidos!${NC}"
        echo "💡 Para reinstalar: ./install.sh"
        ;;
esac

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

# Pergunta se quer remover os instaladores
read -p "Deseja remover também os scripts de instalação? (s/N): " REMOVE_INSTALLER
if [[ $REMOVE_INSTALLER =~ ^[Ss]$ ]]; then
    log_info "Removendo scripts de instalação..."

    sleep 1
    rm -f install.sh 2>/dev/null || true
    rm -f uninstall.sh 2>/dev/null || true

    log_success "Scripts de instalação removidos"
else
    log_info "Scripts de instalação mantidos"
    echo "   • install.sh"
    echo "   • uninstall.sh"
fi

echo ""
echo "Obrigado por usar o RENOMER!"
echo ""

exit 0