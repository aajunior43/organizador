@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ============================================
:: RENOMER - Desinstalador
:: Sistema de Organização de Extratos Bancários
:: ============================================

title RENOMER - Desinstalador

color 0C

cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║        RENOMER - DESINSTALADOR                            ║
echo ║        Sistema de Organização de Extratos Bancários       ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo  Desenvolvido por: DEV ALEKSANDRO ALVES
echo  Versão: 2.0.0
echo.
echo ════════════════════════════════════════════════════════════
echo.
echo ⚠️  ATENÇÃO: Este script irá remover componentes do RENOMER
echo.

:: Pergunta confirmação
set /p CONFIRM="Deseja realmente desinstalar o RENOMER? (S/N): "
if /i not "%CONFIRM%"=="S" (
    echo.
    echo [INFO] Desinstalação cancelada pelo usuário
    timeout /t 2 >nul
    exit /b 0
)

echo.
echo ════════════════════════════════════════════════════════════
echo.

:: Opções de desinstalação
echo O que deseja remover?
echo.
echo [1] Apenas ambiente virtual e dependências (Recomendado)
echo [2] Ambiente virtual + arquivos temporários e logs
echo [3] TUDO (incluindo extratos e arquivos organizados)
echo [4] Cancelar
echo.
set /p UNINSTALL_TYPE="Escolha uma opção (1-4): "

if "%UNINSTALL_TYPE%"=="4" (
    echo.
    echo [INFO] Desinstalação cancelada
    timeout /t 2 >nul
    exit /b 0
)

echo.
echo ════════════════════════════════════════════════════════════
echo.
echo [INFO] Iniciando desinstalação...
echo.

set ITEMS_REMOVED=0

:: Opção 1, 2 ou 3: Remove ambiente virtual
if "%UNINSTALL_TYPE%" geq "1" (
    echo [1/7] Removendo ambiente virtual...
    if exist "venv\" (
        rmdir /s /q "venv" 2>nul
        if exist "venv\" (
            echo [AVISO] Não foi possível remover completamente o ambiente virtual
        ) else (
            echo [OK] Ambiente virtual removido
            set /a ITEMS_REMOVED+=1
        )
    ) else (
        echo [INFO] Ambiente virtual não encontrado
    )
    echo.
)

:: Opção 1, 2 ou 3: Remove cache Python
if "%UNINSTALL_TYPE%" geq "1" (
    echo [2/7] Removendo cache Python...

    :: Remove __pycache__
    for /d /r %%d in (__pycache__) do (
        if exist "%%d" (
            rmdir /s /q "%%d" 2>nul
            echo [OK] Removido: %%d
            set /a ITEMS_REMOVED+=1
        )
    )

    :: Remove .pyc
    del /s /q *.pyc 2>nul

    echo [OK] Cache Python removido
    echo.
)

:: Opção 2 ou 3: Remove logs
if "%UNINSTALL_TYPE%" geq "2" (
    echo [3/7] Removendo logs...
    if exist "logs\" (
        rmdir /s /q "logs" 2>nul
        echo [OK] Logs removidos
        set /a ITEMS_REMOVED+=1
    ) else (
        echo [INFO] Pasta de logs não encontrada
    )
    echo.
)

:: Opção 2 ou 3: Remove arquivos temporários
if "%UNINSTALL_TYPE%" geq "2" (
    echo [4/7] Removendo arquivos temporários...

    if exist "temp\" (
        rmdir /s /q "temp" 2>nul
        echo [OK] Pasta temp removida
        set /a ITEMS_REMOVED+=1
    )

    if exist "*.log" (
        del /q *.log 2>nul
        echo [OK] Arquivos .log removidos
        set /a ITEMS_REMOVED+=1
    )

    if exist "interface_config.json" (
        del /q interface_config.json 2>nul
        echo [OK] Configuração da interface removida
        set /a ITEMS_REMOVED+=1
    )

    echo [OK] Arquivos temporários removidos
    echo.
)

:: Opção 3: Remove TUDO
if "%UNINSTALL_TYPE%"=="3" (
    echo [5/7] Removendo extratos e arquivos organizados...
    echo.
    echo ⚠️  AVISO: Você está prestes a DELETAR TODOS OS ARQUIVOS!
    echo     Isso inclui extratos e arquivos organizados.
    echo.
    set /p CONFIRM_DELETE="Tem certeza ABSOLUTA? Digite 'SIM' para confirmar: "

    if /i "!CONFIRM_DELETE!"=="SIM" (
        if exist "extratos\" (
            rmdir /s /q "extratos" 2>nul
            echo [OK] Pasta extratos removida
            set /a ITEMS_REMOVED+=1
        )

        if exist "ORGANIZADO\" (
            rmdir /s /q "ORGANIZADO" 2>nul
            echo [OK] Pasta ORGANIZADO removida
            set /a ITEMS_REMOVED+=1
        )

        if exist "resultado_organizacao\" (
            rmdir /s /q "resultado_organizacao" 2>nul
            echo [OK] Pasta resultado_organizacao removida
            set /a ITEMS_REMOVED+=1
        )

        if exist "relatorios\" (
            rmdir /s /q "relatorios" 2>nul
            echo [OK] Pasta relatorios removida
            set /a ITEMS_REMOVED+=1
        )

        echo [OK] Todos os arquivos de dados removidos
    ) else (
        echo [INFO] Remoção de dados cancelada
    )
    echo.
)

:: Remove atalhos criados
echo [6/7] Removendo atalhos...

if exist "RENOMER_Interface.bat" (
    del /q "RENOMER_Interface.bat" 2>nul
    echo [OK] RENOMER_Interface.bat removido
    set /a ITEMS_REMOVED+=1
)

if exist "RENOMER_API.bat" (
    del /q "RENOMER_API.bat" 2>nul
    echo [OK] RENOMER_API.bat removido
    set /a ITEMS_REMOVED+=1
)

:: Remove atalho da área de trabalho
if exist "%USERPROFILE%\Desktop\RENOMER.lnk" (
    del /q "%USERPROFILE%\Desktop\RENOMER.lnk" 2>nul
    echo [OK] Atalho da área de trabalho removido
    set /a ITEMS_REMOVED+=1
)

echo.

:: Limpa arquivos auxiliares
echo [7/7] Limpeza final...

if exist "CreateShortcut.vbs" del /q "CreateShortcut.vbs" 2>nul
if exist "nul" del /q "nul" 2>nul

echo [OK] Limpeza concluída
echo.

:: Resumo
echo ════════════════════════════════════════════════════════════
echo.
echo ✅ DESINSTALAÇÃO CONCLUÍDA!
echo.
echo 📊 Resumo:
echo    • Itens removidos: %ITEMS_REMOVED%
echo    • Tipo de desinstalação: Opção %UNINSTALL_TYPE%
echo.

if "%UNINSTALL_TYPE%"=="1" (
    echo 📝 Arquivos mantidos:
    echo    • Código fonte do programa
    echo    • Extratos e arquivos organizados
    echo    • Configurações
    echo    • Logs
    echo.
    echo 💡 Para reinstalar: execute install.bat
)

if "%UNINSTALL_TYPE%"=="2" (
    echo 📝 Arquivos mantidos:
    echo    • Código fonte do programa
    echo    • Extratos e arquivos organizados
    echo.
    echo 💡 Para reinstalar: execute install.bat
)

if "%UNINSTALL_TYPE%"=="3" (
    echo 📝 Arquivos mantidos:
    echo    • Código fonte do programa
    echo    • Documentação
    echo.
    echo ⚠️  Todos os dados foram removidos!
    echo 💡 Para reinstalar: execute install.bat
)

echo.
echo ════════════════════════════════════════════════════════════
echo.

:: Pergunta se quer remover o instalador/desinstalador
set /p REMOVE_INSTALLER="Deseja remover também os scripts de instalação? (S/N): "
if /i "%REMOVE_INSTALLER%"=="S" (
    echo.
    echo [INFO] Criando script de auto-remoção...

    :: Cria script que se auto-remove
    echo @echo off > remove_installers.bat
    echo timeout /t 2 /nobreak ^>nul >> remove_installers.bat
    echo del /q install.bat 2^>nul >> remove_installers.bat
    echo del /q uninstall.bat 2^>nul >> remove_installers.bat
    echo del /q "%%~f0" 2^>nul >> remove_installers.bat

    echo [OK] Os instaladores serão removidos em 2 segundos...
    start /min remove_installers.bat
) else (
    echo.
    echo [INFO] Scripts de instalação mantidos
    echo        • install.bat
    echo        • uninstall.bat
)

echo.
echo Obrigado por usar o RENOMER!
echo.
echo Pressione qualquer tecla para sair...
pause >nul

exit /b 0