# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_all
import os

# Inclui apenas os arquivos essenciais do código
datas = [
    ('src/core', 'src/core'), 
    ('src/utils', 'src/utils'), 
    ('src/utils/relatorio_manager.py', '.'),
    ('src/reports', 'src/reports'),
    ('config', 'config'),
    ('src/core/organizador_local_avancado.py', 'src/core'),
    ('src/core/organizador_super_avancado.py', 'src/core'),
    ('src/core/app.py', 'src/core')
]

binaries = []

# Importações ocultas necessárias para o funcionamento
hiddenimports = [
    'tkinter', 
    'tkinter.ttk', 
    'tkinter.filedialog',
    'tkinter.messagebox',
    'tkinter.scrolledtext',
    'logging.handlers',
    'threading',
    'json',
    'datetime',
    'webbrowser',
    'subprocess',
    'pathlib',
    'os.path',
    'sys',
    'relatorio_manager',
    'src.utils.relatorio_manager',
    'src.core.organizador_local_avancado',
    'src.core.organizador_super_avancado',
    'src.core.app'
]

# Coleta todas as dependências do tkinter
tmp_ret = collect_all('tkinter')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]


a = Analysis(
    ['src\\ui\\interface_com_seletor.py'],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='RENOMER_Portable',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,  # Desabilitado para melhor compatibilidade
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,  # Habilitado para debug em caso de erro
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=None,  # Pode adicionar um ícone aqui se desejar
    version=None,  # Pode adicionar informações de versão aqui
)
