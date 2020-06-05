#!/bin/bash
#inciando o projeto
echo "### Inciando o projeto ###"

echo "Verificando branch"
git checkout develop

echo "Baixando dados do projeto"
git pull

echo "Instalando dependências e inciando o projeto"
composer install
cp .env.localhost .env
composer dumpautoload
php artisan key:generate

##host do windows

#vhosts
host_url=laravel_shell
project_dir="${PWD/#$HOME/C:/Users/$USERNAME}"
apache_dir="D:\xampp\apache\conf\extra\httpd-vhosts.conf"
# shellcheck disable=SC2089
new_vhost="\n\n
<VirtualHost *:80> \n
      DocumentRoot $project_dir\public' \n
      ServerName $host_url.localhost \n
      ServerAlias $host_url.localhost \n
      <Directory '$project_dir\public'> \n
         AllowOverride All \n
         Require all Granted \n
     </Directory> \n
</VirtualHost>"
echo -e $new_vhost >>$apache_dir

#reiniciando o xampp
echo "Reiniciando o apache..."
cd /d/xampp
start apache_stop.bat
start apache_start.bat

echo "O projeto esta rodando em: http://$host_url.localhost"
echo "### Fim da instalação ###"

