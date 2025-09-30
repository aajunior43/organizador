@echo off
chcp 65001 >nul
cls

echo ===============================================
echo   INSTALADOR - ORGANIZADOR DE EXTRATOS v2.0
echo ===============================================
echo.
echo Este script verificara e configurara o sistema.
echo.

:: Verifica Python
echo [1/3] Verificando Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao encontrado!
    echo.
    echo Instale Python 3.6+ em: https://python.org/downloads
    echo.
    pause
    exit /b 1
) else (
    for /f "tokens=2" %%v in ('python --version 2^>^&1') do set PYTHON_VERSION=%%v
    echo OK: Python !PYTHON_VERSION! encontrado
)

:: Verifica estrutura de diretórios
echo.
echo [2/3] Verificando estrutura de diretorios...
if not exist "src\core" (
    echo ERRO: Estrutura de diretorios incompleta!
    echo Execute este script no diretorio correto.
    pause
    exit /b 1
)
echo OK: Estrutura de diretorios presente

:: Cria diretórios de trabalho se não existirem
echo.
echo [3/3] Criando diretorios de trabalho...
if not exist "logs" mkdir logs
if not exist "outputs" mkdir outputs
if not exist "temp" mkdir temp
echo OK: Diretorios de trabalho criados

:: Verifica arquivos essenciais
echo.
echo Verificando arquivos essenciais...
set MISSING=0

if not exist "src\ui\interface_com_seletor.py" (
    echo ERRO: Interface nao encontrada
    set MISSING=1
)

if not exist "src\core\organizador_local_avancado.py" (
    echo ERRO: Organizador nao encontrado
    set MISSING=1
)

if not exist "config\config.py" (
    echo ERRO: Configuracao nao encontrada
    set MISSING=1
)

if %MISSING%==1 (
    echo.
    echo ERRO: Arquivos essenciais ausentes!
    echo Verifique a integridade da instalacao.
    pause
    exit /b 1
)

echo OK: Todos os arquivos essenciais presentes

echo.
echo ===============================================
echo   INSTALACAO CONCLUIDA COM SUCESSO!
echo ===============================================
echo.
echo Para usar o sistema:
echo 1. Execute INICIAR.bat
echo 2. Selecione pastas de origem e destino
echo 3. Execute a organizacao
echo.
echo Documentacao completa em: docs\README.md
echo.
pause