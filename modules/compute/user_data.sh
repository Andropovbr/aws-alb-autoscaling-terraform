#!/bin/bash
# Atualiza os pacotes
sudo apt update -y

# Instala Nginx
sudo apt install -y nginx

# Cria uma página inicial simples
echo "<h1>Instância criada com Terraform 🚀</h1>" | sudo tee /var/www/html/index.html

# Inicia o serviço Nginx
sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx
sudo echo "<h1>Olá! NGINX instalado com Terraform e user_data.sh</h1>" > /usr/share/nginx/html/index.html
