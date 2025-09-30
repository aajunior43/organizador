@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ============================================
:: RENOMER - Instalador Automático
:: Sistema de Organização de Extratos Bancários
:: ============================================

title RENOMER - Instalador

:: Cores
color 0B

cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║        RENOMER - INSTALADOR DO SISTEMA                    ║
echo ║        Sistema de Organização de Extratos Bancários       ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo  Desenvolvido por: DEV ALEKSANDRO ALVES
echo  Versão: 2.0.0
echo.
echo ════════════════════════════════════════════════════════════
echo.

:: Verifica se está rodando como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [AVISO] Este script precisa de permissões de administrador.
    echo [AVISO] Algumas funcionalidades podem não funcionar corretamente.
    echo.
    timeout /t 3 >nul
)

:: Verifica Python
echo [1/8] Verificando Python...
python --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERRO] Python não encontrado!
    echo.
    echo Por favor, instale Python 3.7 ou superior:
    echo https://www.python.org/downloads/
    echo.
    echo Durante a instalação, marque a opção "Add Python to PATH"
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo [OK] Python %PYTHON_VERSION% encontrado
echo.

:: Verifica pip
echo [2/8] Verificando pip...
python -m pip --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [AVISO] pip não encontrado. Tentando instalar...
    python -m ensurepip --default-pip
    if %errorLevel% neq 0 (
        echo [ERRO] Não foi possível instalar o pip
        pause
        exit /b 1
    )
)
echo [OK] pip encontrado
echo.

:: Atualiza pip
echo [3/8] Atualizando pip...
python -m pip install --upgrade pip --quiet
if %errorLevel% equ 0 (
    echo [OK] pip atualizado
) else (
    echo [AVISO] Não foi possível atualizar o pip, continuando...
)
echo.

:: Cria ambiente virtual (opcional)
echo [4/8] Configurando ambiente...
if exist "venv" (
    echo [INFO] Ambiente virtual já existe
) else (
    echo [INFO] Criando ambiente virtual...
    python -m venv venv
    if %errorLevel% equ 0 (
        echo [OK] Ambiente virtual criado
    ) else (
        echo [AVISO] Não foi possível criar ambiente virtual, instalando globalmente...
    )
)
echo.

:: Ativa ambiente virtual se existir
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
    echo [INFO] Ambiente virtual ativado
    echo.
)

:: Instala dependências
echo [5/8] Instalando dependências...
echo [INFO] Isso pode levar alguns minutos...
echo.

if exist "requirements.txt" (
    python -m pip install -r requirements.txt --quiet
    if %errorLevel% equ 0 (
        echo [OK] Todas as dependências instaladas com sucesso
    ) else (
        echo [ERRO] Falha ao instalar algumas dependências
        echo [INFO] Tentando instalar dependências essenciais...

        :: Instala dependências essenciais uma por uma
        python -m pip install flask --quiet
        python -m pip install flask-cors --quiet
        python -m pip install werkzeug --quiet
        python -m pip install psutil --quiet

        echo [OK] Dependências essenciais instaladas
    )
) else (
    echo [ERRO] Arquivo requirements.txt não encontrado
    pause
    exit /b 1
)
echo.

:: Cria estrutura de diretórios
echo [6/8] Criando estrutura de diretórios...

if not exist "logs" mkdir logs
if not exist "extratos" mkdir extratos
if not exist "ORGANIZADO" mkdir ORGANIZADO
if not exist "relatorios" mkdir relatorios
if not exist "relatorios\html" mkdir relatorios\html
if not exist "relatorios\json" mkdir relatorios\json
if not exist "relatorios\simulacoes" mkdir relatorios\simulacoes
if not exist "relatorios\organizacoes" mkdir relatorios\organizacoes

echo [OK] Estrutura de diretórios criada
echo.

:: Cria atalhos
echo [7/8] Criando atalhos...

:: Atalho para interface gráfica
if exist "src\ui\interface_com_seletor.py" (
    echo @echo off > RENOMER_Interface.bat
    echo cd /d "%%~dp0" >> RENOMER_Interface.bat
    echo title RENOMER - Interface Grafica >> RENOMER_Interface.bat
    echo if exist "venv\Scripts\activate.bat" call venv\Scripts\activate.bat >> RENOMER_Interface.bat
    echo python src\ui\interface_com_seletor.py >> RENOMER_Interface.bat
    echo pause >> RENOMER_Interface.bat

    echo [OK] Atalho para interface criado: RENOMER_Interface.bat
)

:: Atalho para API
if exist "src\core\app.py" (
    echo @echo off > RENOMER_API.bat
    echo cd /d "%%~dp0" >> RENOMER_API.bat
    echo title RENOMER - API Server >> RENOMER_API.bat
    echo if exist "venv\Scripts\activate.bat" call venv\Scripts\activate.bat >> RENOMER_API.bat
    echo python src\core\app.py >> RENOMER_API.bat
    echo pause >> RENOMER_API.bat

    echo [OK] Atalho para API criado: RENOMER_API.bat
)

echo.

:: Testa instalação
echo [8/8] Testando instalação...

python -c "import flask; import tkinter" >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Teste de importação bem-sucedido
) else (
    echo [AVISO] Algumas bibliotecas podem não estar instaladas corretamente
)
echo.

:: Resumo
echo ════════════════════════════════════════════════════════════
echo.
echo ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!
echo.
echo 📁 Estrutura criada:
echo    • logs/                - Logs do sistema
echo    • extratos/            - Coloque seus extratos aqui
echo    • ORGANIZADO/          - Arquivos organizados
echo    • relatorios/          - Relatórios gerados
echo.
echo 🚀 Para iniciar o programa:
echo    • Interface Gráfica:   RENOMER_Interface.bat
echo    • API Server:          RENOMER_API.bat
echo.
echo 📚 Documentação:
echo    • API_README.md        - Documentação da API
echo    • GITHUB_SETUP.md      - Instruções do GitHub
echo.
echo 🔧 Comandos úteis:
echo    • Desinstalar:         uninstall.bat
echo    • Atualizar:           git pull (se usar Git)
echo.
echo ════════════════════════════════════════════════════════════
echo.

:: Pergunta se quer criar atalho na área de trabalho
set /p CREATE_SHORTCUT="Deseja criar atalho na área de trabalho? (S/N): "
if /i "%CREATE_SHORTCUT%"=="S" (
    echo.
    echo [INFO] Criando atalho na área de trabalho...

    :: Cria VBS para criar atalho
    echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
    echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\RENOMER.lnk" >> CreateShortcut.vbs
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
    echo oLink.TargetPath = "%CD%\RENOMER_Interface.bat" >> CreateShortcut.vbs
    echo oLink.WorkingDirectory = "%CD%" >> CreateShortcut.vbs
    echo oLink.Description = "RENOMER - Organizador de Extratos" >> CreateShortcut.vbs
    echo oLink.Save >> CreateShortcut.vbs

    cscript //nologo CreateShortcut.vbs
    del CreateShortcut.vbs

    echo [OK] Atalho criado na área de trabalho
    echo.
)

echo Pressione qualquer tecla para iniciar a interface gráfica...
pause >nul

:: Inicia a interface
if exist "RENOMER_Interface.bat" (
    start "" "RENOMER_Interface.bat"
)

exit /b 0