#!/bin/bash
#inciando o projeto
echo "### Inciando o projeto ###"

echo "Verificando branch..."
git checkout develop

echo "Baixando dados do projeto..."
git pull

echo "Instalando dependências e inciando o projeto..."
composer install
cp .env.localhost .env
composer dumpautoload
php artisan key:generate

echo "Pegando o nome do projeto..."
path=${PWD}
cd ../
path_back=${PWD}
path_origin=${path//"$path_back/"/}

#host do windows
host_url=$path_origin.localhost
echo -e "\n 127.0.0.1 $host_url" >> "C:\Windows\System32\drivers\etc\hosts"

#vhosts
project_dir="${PWD/#$HOME/C:/Users/$USERNAME}"
apache_dir="D:\xampp\apache\conf\extra\httpd-vhosts.conf"
# shellcheck disable=SC2089
new_vhost="\n\n
<VirtualHost *:80> \n
      DocumentRoot $project_dir\public' \n
      ServerName $host_url \n
      ServerAlias $host_url \n
      <Directory '$project_dir\public'> \n
         AllowOverride All \n
         Require all Granted \n
     </Directory> \n
</VirtualHost>"
echo -e $new_vhost >>$apache_dir

#reiniciando o xampp
echo "Reiniciando o apache..."
cd D:\xampp
start apache_stop.bat
start apache_start.bat

echo "O projeto esta rodando em: http://$host_url"
echo "### Fim da instalação ###"
