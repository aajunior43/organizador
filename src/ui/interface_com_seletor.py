#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Interface Gráfica com Seletor de Diretórios
Interface moderna para o sistema de organização de arquivos
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
import os
import sys
import json
import threading
from datetime import datetime
import webbrowser
import subprocess

# Adiciona o diretório utils ao path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'utils'))
from relatorio_manager import relatorio_manager

class InterfaceComSeletor:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Organizador de Extratos - Sistema Local")
        self.root.geometry("800x600")
        self.root.resizable(True, True)

        # Variáveis para caminhos
        self.pasta_origem = tk.StringVar()
        self.pasta_destino = tk.StringVar()

        # Carrega configurações salvas
        self.carregar_configuracoes()

        # Centralizar janela
        self.centralizar_janela()

        # Configurar estilo
        self.configurar_estilo()

        # Criar interface
        self.criar_interface()

    def centralizar_janela(self):
        """Centraliza a janela na tela"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')

    def configurar_estilo(self):
        """Configura o estilo da interface"""
        style = ttk.Style()
        style.theme_use('clam')

        # Estilos customizados para os botões
        style.configure('Simulation.TButton',
                       background='lightblue',
                       font=('Arial', 10, 'bold'))
        style.configure('Action.TButton',
                       background='lightgreen',
                       font=('Arial', 10, 'bold'))

    def carregar_configuracoes(self):
        """Carrega configurações salvas"""
        try:
            if os.path.exists('interface_config.json'):
                with open('interface_config.json', 'r', encoding='utf-8') as f:
                    config = json.load(f)
                    self.pasta_origem.set(config.get('origem', ''))
                    self.pasta_destino.set(config.get('destino', ''))
        except:
            pass

    def salvar_configuracoes(self):
        """Salva configurações atuais"""
        try:
            config = {
                'origem': self.pasta_origem.get(),
                'destino': self.pasta_destino.get()
            }
            with open('interface_config.json', 'w', encoding='utf-8') as f:
                json.dump(config, f, indent=2, ensure_ascii=False)
        except:
            pass

    def criar_interface(self):
        """Cria todos os elementos da interface"""
        # Frame principal
        main_frame = ttk.Frame(self.root, padding="15")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Configurar grid
        self.root.grid_rowconfigure(0, weight=1)
        self.root.grid_columnconfigure(0, weight=1)
        main_frame.grid_rowconfigure(3, weight=1)
        main_frame.grid_columnconfigure(0, weight=1)

        # Título
        title_label = ttk.Label(main_frame, text="ORGANIZADOR DE EXTRATOS - SISTEMA LOCAL",
                               font=('Arial', 16, 'bold'))
        title_label.grid(row=0, column=0, columnspan=2, pady=(0, 20))

        # Área de seleção de pastas
        self.criar_selecao_pastas(main_frame)

        # Botões de ação
        self.criar_botoes_acao(main_frame)

        # Status
        self.criar_status(main_frame)
        
        # Rodapé
        self.criar_rodape(main_frame)

    def criar_selecao_pastas(self, parent):
        """Cria área para seleção de pastas"""
        pastas_frame = ttk.LabelFrame(parent, text="Configuracao de Pastas", padding="10")
        pastas_frame.grid(row=1, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 15))
        pastas_frame.grid_columnconfigure(1, weight=1)

        # Pasta de origem
        ttk.Label(pastas_frame, text="Pasta de Origem:").grid(row=0, column=0, sticky=tk.W, pady=5)

        origem_frame = ttk.Frame(pastas_frame)
        origem_frame.grid(row=0, column=1, sticky=(tk.W, tk.E), padx=(10, 0))
        origem_frame.grid_columnconfigure(0, weight=1)

        self.entry_origem = ttk.Entry(origem_frame, textvariable=self.pasta_origem, width=50)
        self.entry_origem.grid(row=0, column=0, sticky=(tk.W, tk.E), padx=(0, 5))

        btn_origem = ttk.Button(origem_frame, text="Selecionar", command=self.selecionar_origem)
        btn_origem.grid(row=0, column=1)

        # Pasta de destino
        ttk.Label(pastas_frame, text="Pasta de Destino:").grid(row=1, column=0, sticky=tk.W, pady=5)

        destino_frame = ttk.Frame(pastas_frame)
        destino_frame.grid(row=1, column=1, sticky=(tk.W, tk.E), padx=(10, 0))
        destino_frame.grid_columnconfigure(0, weight=1)

        self.entry_destino = ttk.Entry(destino_frame, textvariable=self.pasta_destino, width=50)
        self.entry_destino.grid(row=0, column=0, sticky=(tk.W, tk.E), padx=(0, 5))

        btn_destino = ttk.Button(destino_frame, text="Selecionar", command=self.selecionar_destino)
        btn_destino.grid(row=0, column=1)

        # Informações
        info_text = "Selecione a pasta onde estao os extratos (origem) e onde deseja organizar (destino)"
        ttk.Label(pastas_frame, text=info_text, font=('Arial', 9), foreground='gray').grid(
            row=2, column=0, columnspan=2, pady=(10, 0), sticky=tk.W
        )

    def criar_botoes_acao(self, parent):
        """Cria botões de ação"""
        botoes_frame = ttk.Frame(parent)
        botoes_frame.grid(row=2, column=0, columnspan=2, pady=15)

        # Botão 1: SIMULAR (mostra estatísticas)
        btn_simular = ttk.Button(botoes_frame, text="SIMULAR E VER ESTATISTICAS",
                                command=self.simular_organizacao,
                                width=35,
                                style='Simulation.TButton')
        btn_simular.grid(row=0, column=0, padx=10, pady=5)

        # Botão 2: ORGANIZAR (execução real)
        btn_organizar = ttk.Button(botoes_frame, text="ORGANIZAR EXTRATOS",
                                  command=self.organizar_extratos,
                                  width=35,
                                  style='Action.TButton')
        btn_organizar.grid(row=0, column=1, padx=10, pady=5)

    def criar_status(self, parent):
        """Cria área de status"""
        status_frame = ttk.LabelFrame(parent, text="Status e Log", padding="10")
        status_frame.grid(row=3, column=0, columnspan=2, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 10))
        status_frame.grid_rowconfigure(0, weight=1)
        status_frame.grid_columnconfigure(0, weight=1)

        # Texto de status com scroll
        self.status_text = tk.Text(status_frame, height=15, wrap=tk.WORD)
        self.status_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Scrollbar
        scrollbar = ttk.Scrollbar(status_frame, orient="vertical", command=self.status_text.yview)
        scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))
        self.status_text.configure(yscrollcommand=scrollbar.set)

        # Mensagem inicial
        self.adicionar_status("Sistema Local iniciado. Selecione as pastas e escolha uma acao.")
        self.adicionar_status("IMPORTANTE: Arquivos serao COPIADOS (originais preservados)")
        self.adicionar_status("DETECCAO AUTOMATICA de:")
        self.adicionar_status("  - Datas: 06/2023, JUN/2023, JUNHO, 202306, etc")
        self.adicionar_status("  - Contas: 12345-6, Extrato123456, EXT JUNHO 12345-X")
        self.adicionar_status("  - Estrutura: CONTA_123456/2023_06_JUNHO/")

    def criar_rodape(self, parent):
        """Cria rodapé com informações do desenvolvedor"""
        rodape_frame = ttk.Frame(parent)
        rodape_frame.grid(row=4, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(10, 0))
        
        # Label do desenvolvedor
        dev_label = ttk.Label(rodape_frame, text="DEV ALEKSANDRO ALVES", 
                             font=('Arial', 9, 'italic'), 
                             foreground='gray')
        dev_label.grid(row=0, column=0, sticky=tk.E)
        
        # Configurar para que o texto fique alinhado à direita
        rodape_frame.grid_columnconfigure(0, weight=1)

    def adicionar_status(self, mensagem):
        """Adiciona mensagem ao status"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.status_text.insert(tk.END, f"[{timestamp}] {mensagem}\n")
        self.status_text.see(tk.END)
        self.root.update()

    def copiar_arquivos_para_destino(self, arquivo_json, arquivo_html, pasta_destino):
        """Copia arquivos de log JSON e HTML para a pasta de destino"""
        try:
            # Cria subpasta 'relatorios' na pasta de destino
            pasta_relatorios = os.path.join(pasta_destino, "relatorios")
            os.makedirs(pasta_relatorios, exist_ok=True)
            
            # Copia arquivo JSON
            if os.path.exists(arquivo_json):
                destino_json = os.path.join(pasta_relatorios, os.path.basename(arquivo_json))
                shutil.copy2(arquivo_json, destino_json)
                self.adicionar_status(f"Log JSON copiado para: {destino_json}")
            
            # Copia arquivo HTML
            if os.path.exists(arquivo_html):
                destino_html = os.path.join(pasta_relatorios, os.path.basename(arquivo_html))
                shutil.copy2(arquivo_html, destino_html)
                self.adicionar_status(f"Relatorio HTML copiado para: {destino_html}")
                
        except Exception as e:
            self.adicionar_status(f"Erro ao copiar arquivos para destino: {str(e)}")

    def selecionar_origem(self):
        """Seleciona pasta de origem"""
        pasta = filedialog.askdirectory(
            title="Selecionar Pasta de Origem (onde estao os extratos)",
            initialdir=self.pasta_origem.get() or os.getcwd()
        )
        if pasta:
            self.pasta_origem.set(pasta)
            self.salvar_configuracoes()
            self.adicionar_status(f"Pasta de origem selecionada: {pasta}")

    def selecionar_destino(self):
        """Seleciona pasta de destino"""
        pasta = filedialog.askdirectory(
            title="Selecionar Pasta de Destino (onde organizar)",
            initialdir=self.pasta_destino.get() or os.getcwd()
        )
        if pasta:
            self.pasta_destino.set(pasta)
            self.salvar_configuracoes()
            self.adicionar_status(f"Pasta de destino selecionada: {pasta}")

    def validar_pastas(self):
        """Valida se as pastas estão selecionadas"""
        origem = self.pasta_origem.get().strip()
        destino = self.pasta_destino.get().strip()

        if not origem:
            messagebox.showerror("Erro", "Selecione a pasta de origem!")
            return False

        if not destino:
            messagebox.showerror("Erro", "Selecione a pasta de destino!")
            return False

        if not os.path.exists(origem):
            messagebox.showerror("Erro", f"Pasta de origem nao existe: {origem}")
            return False

        if origem == destino:
            messagebox.showerror("Erro", "Pasta de origem e destino nao podem ser iguais!")
            return False

        return True

    def executar_organizador(self, modo_teste=False):
        """Executa o organizador"""
        if not self.validar_pastas():
            return

        def run():
            try:
                from core.organizador_local_avancado import OrganizadorLocalAvancado

                origem = self.pasta_origem.get()
                destino = self.pasta_destino.get()

                self.adicionar_status(f"Iniciando organizacao...")
                self.adicionar_status(f"Origem: {origem}")
                self.adicionar_status(f"Destino: {destino}")
                self.adicionar_status(f"Modo: {'TESTE' if modo_teste else 'REAL'}")

                organizador = OrganizadorLocalAvancado(origem, destino)
                relatorio = organizador.organizar_arquivos(modo_teste=modo_teste)

                # Salva relatório na nova estrutura
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                nome_relatorio = f"relatorio_local_{timestamp}.json"
                
                caminho_salvo = relatorio_manager.salvar_relatorio_json(
                    relatorio, 
                    'organizacoes', 
                    nome_relatorio
                )

                self.adicionar_status("ORGANIZACAO CONCLUIDA!")
                self.adicionar_status(f"Total: {relatorio['total_arquivos']}")
                self.adicionar_status(f"Sucessos: {relatorio['processados_com_sucesso']}")
                self.adicionar_status(f"Erros: {relatorio['erros']}")
                self.adicionar_status(f"Relatorio salvo: {nome_relatorio}")

                if relatorio['erros'] > 0:
                    self.adicionar_status("ARQUIVOS COM ERRO:")
                    for detalhe in relatorio['detalhes']:
                        if not detalhe['sucesso']:
                            self.adicionar_status(f"  - {detalhe['nome_original']}: {detalhe['erro']}")

            except Exception as e:
                self.adicionar_status(f"ERRO: {str(e)}")

        thread = threading.Thread(target=run)
        thread.daemon = True
        thread.start()

    def simular_organizacao(self):
        """Simula organização e mostra estatísticas detalhadas"""
        if not self.validar_pastas():
            return

        def run():
            try:
                from core.organizador_local_avancado import OrganizadorLocalAvancado

                origem = self.pasta_origem.get()
                destino = self.pasta_destino.get()

                self.adicionar_status("=== SIMULACAO INICIADA ===")
                self.adicionar_status(f"Analisando arquivos em: {origem}")

                organizador = OrganizadorLocalAvancado(origem, destino)
                relatorio = organizador.organizar_arquivos(modo_teste=True)

                # Estatísticas detalhadas
                self.adicionar_status("")
                self.adicionar_status("ESTATISTICAS DA SIMULACAO:")
                self.adicionar_status(f"   Total de arquivos encontrados: {relatorio['total_arquivos']}")
                self.adicionar_status(f"   Arquivos que serao organizados: {relatorio['processados_com_sucesso']}")
                self.adicionar_status(f"   Arquivos com problemas: {relatorio['erros']}")

                if relatorio['total_arquivos'] > 0:
                    taxa = (relatorio['processados_com_sucesso'] / relatorio['total_arquivos']) * 100
                    self.adicionar_status(f"   Taxa de sucesso: {taxa:.1f}%")

                # Contadores por conta
                contas = {}
                for detalhe in relatorio['detalhes']:
                    if detalhe['sucesso']:
                        conta = detalhe['detalhes']['conta']['conta']
                        contas[conta] = contas.get(conta, 0) + 1

                if contas:
                    self.adicionar_status("")
                    self.adicionar_status("ARQUIVOS POR CONTA:")
                    for conta, qtd in sorted(contas.items()):
                        self.adicionar_status(f"   CONTA_{conta}: {qtd} arquivos")

                # Salva relatório automaticamente na nova estrutura
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                nome_relatorio = f"simulacao_{timestamp}.json"
                
                caminho_salvo = relatorio_manager.salvar_relatorio_json(
                    relatorio, 
                    'simulacoes', 
                    nome_relatorio
                )

                self.adicionar_status("")
                self.adicionar_status(f"Relatorio salvo: {nome_relatorio}")

                # Gera e abre relatório HTML automaticamente
                nome_html = self.gerar_relatorio_automatico(relatorio, nome_relatorio)
                
                # Copia arquivos para pasta de destino
                destino = self.pasta_destino.get()
                if nome_html and destino:
                    self.copiar_arquivos_para_destino(nome_relatorio, nome_html, destino)
                
                self.adicionar_status("=== SIMULACAO CONCLUIDA ===")

                if relatorio['erros'] > 0:
                    self.adicionar_status("")
                    self.adicionar_status("ARQUIVOS COM PROBLEMAS:")
                    for detalhe in relatorio['detalhes']:
                        if not detalhe['sucesso']:
                            self.adicionar_status(f"   - {detalhe['nome_original']}: {detalhe['erro']}")

            except Exception as e:
                self.adicionar_status(f"ERRO na simulacao: {str(e)}")

        thread = threading.Thread(target=run)
        thread.daemon = True
        thread.start()

    def organizar_extratos(self):
        """Organiza extratos (modo real) com relatórios automáticos"""
        if not messagebox.askyesno("Confirmar Organização",
                                  "Executar ORGANIZACAO REAL?\n\n"
                                  "✓ Arquivos serão COPIADOS (originais preservados)\n"
                                  "✓ Relatórios serão gerados automaticamente\n"
                                  "✓ Estrutura organizada será criada"):
            return

        def run():
            try:
                from core.organizador_local_avancado import OrganizadorLocalAvancado

                origem = self.pasta_origem.get()
                destino = self.pasta_destino.get()

                self.adicionar_status("=== ORGANIZACAO REAL INICIADA ===")
                self.adicionar_status(f"Origem: {origem}")
                self.adicionar_status(f"Destino: {destino}")

                organizador = OrganizadorLocalAvancado(origem, destino)
                relatorio = organizador.organizar_arquivos(modo_teste=False)

                # Resultados finais
                self.adicionar_status("")
                self.adicionar_status("ORGANIZACAO CONCLUIDA!")
                self.adicionar_status(f"   Arquivos processados: {relatorio['processados_com_sucesso']}")
                self.adicionar_status(f"   Erros: {relatorio['erros']}")

                # Salva relatório automaticamente
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                nome_relatorio = f"organizacao_{timestamp}.json"
                with open(nome_relatorio, 'w', encoding='utf-8') as f:
                    json.dump(relatorio, f, indent=2, ensure_ascii=False)

                self.adicionar_status(f"Relatorio salvo: {nome_relatorio}")

                # Gera e abre relatório HTML automaticamente
                nome_html = self.gerar_relatorio_automatico(relatorio, nome_relatorio)
                
                # Copia arquivos para pasta de destino
                if nome_html and destino:
                    self.copiar_arquivos_para_destino(nome_relatorio, nome_html, destino)

                # Abre pasta de destino automaticamente
                self.adicionar_status("Abrindo pasta de destino...")
                try:
                    os.startfile(destino)
                except:
                    self.adicionar_status(f"Pasta de destino: {destino}")

            except Exception as e:
                self.adicionar_status(f"ERRO na organizacao: {str(e)}")

        thread = threading.Thread(target=run)
        thread.daemon = True
        thread.start()

    def gerar_relatorio_automatico(self, relatorio_data, nome_arquivo):
        """Gera relatório HTML automaticamente e abre"""
        try:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            nome_html = f"relatorio_{timestamp}.html"

            # Gera HTML
            html_content = self.criar_relatorio_html(relatorio_data)

            with open(nome_html, 'w', encoding='utf-8') as f:
                f.write(html_content)

            # Abre automaticamente
            os.startfile(nome_html)
            self.adicionar_status(f"Relatorio HTML gerado e aberto: {nome_html}")
            
            return nome_html

        except Exception as e:
            self.adicionar_status(f"Erro ao gerar relatorio HTML: {str(e)}")
            return None

    def criar_relatorio_html(self, relatorio):
        """Cria relatório HTML detalhado"""
        html = f"""
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório de Organização - {datetime.now().strftime('%d/%m/%Y %H:%M')}</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .header {{ background: #f0f0f0; padding: 20px; border-radius: 5px; }}
        .stats {{ display: flex; gap: 20px; margin: 20px 0; }}
        .stat-box {{ background: #e8f4f8; padding: 15px; border-radius: 5px; flex: 1; text-align: center; }}
        .success {{ background: #d4edda; }}
        .error {{ background: #f8d7da; }}
        table {{ width: 100%; border-collapse: collapse; margin: 20px 0; }}
        th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
        th {{ background: #f2f2f2; }}
        .status-success {{ color: green; font-weight: bold; }}
        .status-error {{ color: red; font-weight: bold; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>📊 Relatório de Organização de Extratos</h1>
        <p><strong>Data:</strong> {datetime.now().strftime('%d/%m/%Y às %H:%M:%S')}</p>
        <p><strong>Modo:</strong> {'SIMULAÇÃO' if relatorio['modo_teste'] else 'ORGANIZAÇÃO REAL'}</p>
    </div>

    <div class="stats">
        <div class="stat-box">
            <h3>{relatorio['total_arquivos']}</h3>
            <p>Total de Arquivos</p>
        </div>
        <div class="stat-box success">
            <h3>{relatorio['processados_com_sucesso']}</h3>
            <p>Sucessos</p>
        </div>
        <div class="stat-box error">
            <h3>{relatorio['erros']}</h3>
            <p>Erros</p>
        </div>
    </div>

    <h2>📋 Detalhes dos Arquivos</h2>
    <table>
        <tr>
            <th>Arquivo Original</th>
            <th>Status</th>
            <th>Estrutura de Destino</th>
            <th>Conta</th>
            <th>Data</th>
        </tr>
"""

        for detalhe in relatorio['detalhes']:
            status_class = "status-success" if detalhe['sucesso'] else "status-error"
            status_text = "✓ Sucesso" if detalhe['sucesso'] else f"✗ {detalhe.get('erro', 'Erro')}"

            if detalhe['sucesso']:
                estrutura = detalhe.get('estrutura', 'N/A')
                conta = detalhe['detalhes']['conta']['conta'] or 'N/A'
                data_info = detalhe['detalhes']['data']
                data_str = f"{data_info['mes']}/{data_info['ano']}" if data_info['encontrado'] else 'N/A'
            else:
                estrutura = 'N/A'
                conta = 'N/A'
                data_str = 'N/A'

            html += f"""
        <tr>
            <td>{detalhe['nome_original']}</td>
            <td class="{status_class}">{status_text}</td>
            <td>{estrutura}</td>
            <td>{conta}</td>
            <td>{data_str}</td>
        </tr>
"""

        html += """
    </table>

    <div style="margin-top: 30px; padding: 15px; background: #f8f9fa; border-radius: 5px;">
        <p><small>Relatório gerado automaticamente pelo Organizador de Extratos</small></p>
    </div>
</body>
</html>
"""
        return html

    def executar(self):
        """Executa a interface"""
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
        self.root.mainloop()

    def on_closing(self):
        """Ação ao fechar a janela"""
        self.salvar_configuracoes()
        self.root.quit()

def main():
    """Função principal"""
    try:
        from datetime import datetime
        app = InterfaceComSeletor()
        app.executar()
    except Exception as e:
        print(f"Erro ao iniciar interface: {str(e)}")
        input("Pressione ENTER para fechar...")

if __name__ == "__main__":
    main()