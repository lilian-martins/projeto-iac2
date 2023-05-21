#!/bin/bash

# Variavel para controlar erros
error=0

# Funcao para verificar e exibir o resultado de um comando
check_command() {
    if [ $1 -eq 0 ]; then
        echo "[OK] $2"
    else
        echo "[ERRO] $2"
        error=1
    fi
}

# Atualizar o servidor
echo "Atualizando o servidor..."
sudo apt update
check_command $? "Atualizacao do servidor"

sudo apt upgrade -y
check_command $? "Upgrade do servidor"

# Instalar o apache2
echo "Instalando o Apache2..."
sudo apt install apache2 -y
sudo apt install wget -y
check_command $? "Instalacao do Apache2"

# Instalar o unzip
echo "Instalando o unzip..."
sudo apt install unzip -y
check_command $? "Instalacao do unzip"

# Baixar a aplicacao no diretório /tmp
echo "Baixando a aplicacao..."
wget -q https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -P /tmp
check_command $? "Download da aplicacao"

# Extrair a aplicacao
echo "Extraindo a aplicacao..."
unzip -q /tmp/main.zip -d /tmp
check_command $? "Extracao da aplicacao"

# Copiar os arquivos da aplicacao para o diretório padrao do apache
echo "Copiando os arquivos da aplicacao..."
sudo cp -r /tmp/linux-site-dio-main/* /var/www/html/
check_command $? "Cópia dos arquivos da aplicacao"

# Reiniciar o apache
echo "Reiniciando o Apache..."
sudo service apache2 restart
check_command $? "Reinício do Apache"

# Limpar arquivos temporarios
echo "Limpando arquivos temporarios..."
rm -rf /tmp/main.zip /tmp/linux-site-dio-main
check_command $? "Limpeza de arquivos temporarios"

# Exibir checklist
if [ $error -eq 0 ]; then
    echo "-------------------"
    echo "Instalacao concluída!"
else
    echo "-------------------"
    echo "Houve erros durante a instalacao!"
fi
