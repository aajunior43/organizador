@echo off
chcp 65001 >nul
cls

echo ===============================================
echo   ORGANIZADOR DE EXTRATOS BANCARIOS v2.0
echo   Sistema Local Avancado - Sem IA
echo ===============================================
echo.

:: Adiciona diretório src ao PYTHONPATH
set PYTHONPATH=%~dp0;%~dp0src;%PYTHONPATH%

:: Verifica se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao encontrado!
    echo Instale Python 3.6+ e tente novamente.
    pause
    exit /b 1
)

echo Iniciando Interface Grafica...
echo.

:: Executa a interface
python -c "import sys; sys.path.insert(0, 'src'); from ui.interface_com_seletor import main; main()"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao executar a interface.
    echo Verifique se todos os arquivos estao presentes.
    pause
)