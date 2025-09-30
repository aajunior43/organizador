#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Flask Web Server Wrapper for Bank Statement Organizer
Exposes the organizer functionality as REST API endpoints for testing
"""

from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
import os
import sys
import json
import tempfile
from datetime import datetime

# Add the current directory to Python path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Add utils directory to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'utils'))
from relatorio_manager import relatorio_manager

# Import the organizer modules
from organizador_extratos import OrganizadorExtratos
from hybrid_processor import HybridProcessor
import config

app = Flask(__name__)
CORS(app)

# Global organizer instance
organizer = None

def get_organizer():
    """Get or create organizer instance"""
    global organizer
    if organizer is None:
        organizer = OrganizadorExtratos(
            diretorio_base=config.DIRETORIO_BASE_PADRAO,
            diretorio_destino=config.DIRETORIO_DESTINO_PADRAO,
            ano=config.ANO_PADRAO
        )
    return organizer

@app.route('/', methods=['GET'])
def home():
    """Home endpoint"""
    return jsonify({
        "message": "Bank Statement Organizer API",
        "version": "1.0.0",
        "endpoints": [
            "/organize",
            "/analyze",
            "/config",
            "/health"
        ]
    })

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "timestamp": datetime.now().isoformat(),
        "service": "Bank Statement Organizer"
    })

@app.route('/organize', methods=['POST'])
def organize_files():
    """Organize bank statement files"""
    try:
        data = request.get_json() or {}
        
        source_dir = data.get('source_directory', config.DIRETORIO_BASE_PADRAO)
        dest_dir = data.get('destination_directory', config.DIRETORIO_DESTINO_PADRAO)
        test_mode = data.get('test_mode', True)
        
        org = get_organizer()
        org.diretorio_base = source_dir
        org.diretorio_destino = dest_dir
        
        # Run organization in test mode
        resultado = org.executar_organizacao(modo_teste=test_mode)
        
        return jsonify({
            "success": True,
            "total_arquivos": resultado.get('total_arquivos', 0),
            "processados_com_sucesso": resultado.get('processados_com_sucesso', 0),
            "erros": resultado.get('erros', 0),
            "detalhes": resultado.get('detalhes', []),
            "test_mode": test_mode
        })
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

@app.route('/analyze', methods=['POST'])
def analyze_file():
    """Analyze a bank statement file"""
    try:
        data = request.get_json() or {}
        
        filename = data.get('filename', '')
        folder_context = data.get('folder_context', '')
        
        if not filename:
            return jsonify({
                "success": False,
                "error": "Filename is required"
            }), 400
        
        # Create hybrid processor
        processor = HybridProcessor()
        
        # Analyze the filename
        resultado = processor.analyze_filename(filename, folder_context)
        
        return jsonify({
            "success": True,
            "metodo": resultado.get('metodo', 'unknown'),
            "confianca": resultado.get('confianca', 0),
            "mes_numero": resultado.get('mes_numero', ''),
            "mes_nome": resultado.get('mes_nome', ''),
            "numero_conta": resultado.get('numero_conta', ''),
            "tipo_arquivo": resultado.get('tipo_arquivo', '')
        })
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

@app.route('/config', methods=['GET'])
def get_config():
    """Get current configuration"""
    try:
        return jsonify({
            "DIRETORIO_BASE_PADRAO": config.DIRETORIO_BASE_PADRAO,
            "DIRETORIO_DESTINO_PADRAO": config.DIRETORIO_DESTINO_PADRAO,
            "ANO_PADRAO": config.ANO_PADRAO,
            "USAR_GEMINI": getattr(config, 'USAR_GEMINI', False),
            "MODO_TESTE_PADRAO": getattr(config, 'MODO_TESTE_PADRAO', True),
            "FORMATO_NOME_ARQUIVO": config.FORMATO_NOME_ARQUIVO
        })
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

@app.route('/config', methods=['PUT'])
def update_config():
    """Update configuration"""
    try:
        data = request.get_json() or {}
        
        # Update configuration values
        if 'DIRETORIO_BASE_PADRAO' in data:
            config.DIRETORIO_BASE_PADRAO = data['DIRETORIO_BASE_PADRAO']
        if 'DIRETORIO_DESTINO_PADRAO' in data:
            config.DIRETORIO_DESTINO_PADRAO = data['DIRETORIO_DESTINO_PADRAO']
        if 'USAR_GEMINI' in data:
            config.USAR_GEMINI = data['USAR_GEMINI']
        
        return jsonify({
            "success": True,
            "message": "Configuration updated successfully"
        })
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

@app.route('/generate-report', methods=['POST'])
def generate_report():
    """Generate HTML report"""
    try:
        data = request.get_json() or {}
        
        org = get_organizer()
        
        # Generate report with provided data
        report_data = {
            'total_arquivos': data.get('total_arquivos', 0),
            'processados_com_sucesso': data.get('processados_com_sucesso', 0),
            'erros': data.get('erros', 0),
            'detalhes': data.get('detalhes', [])
        }
        
        # Generate HTML report
        html_content = org.gerar_relatorio_html(report_data)
        
        # Save report to organized structure
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        nome_arquivo = f"relatorio_api_{timestamp}.html"
        
        caminho_salvo = relatorio_manager.salvar_relatorio_html(
            html_content, 
            'html', 
            nome_arquivo
        )
        
        return html_content, 200, {'Content-Type': 'text/html'}
        
    except Exception as e:
        return jsonify({
            "success": False,
            "error": str(e)
        }), 500

if __name__ == '__main__':
    print("Starting Bank Statement Organizer API Server...")
    print(f"Base Directory: {config.DIRETORIO_BASE_PADRAO}")
    print(f"Destination Directory: {config.DIRETORIO_DESTINO_PADRAO}")
    print("Server will be available at: http://localhost:8000")
    print("API Documentation available at: http://localhost:8000")

    app.run(host='0.0.0.0', port=8000, debug=True)