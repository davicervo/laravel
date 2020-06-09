#!/bin/bash
#inciando o projeto
echo "### Inciando o projeto ###"

#vhosts
echo "Verificando se o Xampp e Apache estão instalados e serão encontrados."
project_dir="${PWD/#$HOME/C:/Users/$USERNAME}"
apache_dir=""
if [ -f "D:\xampp\apache\conf\extra\httpd-vhosts.conf" ]; then
    apache_dir="D:\xampp\apache\conf\extra\httpd-vhosts.conf"
fi

if [ -f "C:\xampp\apache\conf\extra\httpd-vhosts.conf" ]; then
	apache_dir="C:\xampp\apache\conf\extra\httpd-vhosts.conf"
fi

#tratamento especial para o felipe garcias
if [ -f "C:\Users\Fellipe Garcias\Documents\xampp\apache\conf\extra\httpd-vhosts.conf" ]; then
	apache_dir="C:\Users\Fellipe Garcias\Documents\xampp\apache\conf\extra\httpd-vhosts.conf"
fi

if [ -z "$apache_dir" ]; then
	echo "Diretório do apache não encontrado, o vHost do apache não foi criado."
	exit;
fi
echo "Xampp e Apache encontrados."

echo "Verificando branch..."
git checkout develop

echo "Baixando dados do projeto..."
#git pull

echo "Instalando dependências e inciando o projeto..."
composer install --dev
cp .env.localhost .env
composer dumpautoload
php artisan key:generate
php artisan cache:clear
php artisan route:clear

echo "Pegando o nome do projeto..."
path=${PWD}
cd ../
path_back=${PWD}
path_origin=${path//"$path_back/"/}

#host do windows
host_url=${path_origin,,}
host_url=$host_url.localhost
echo -e "\n127.0.0.1 $host_url" >> "C:\Windows\System32\drivers\etc\hosts"

# shellcheck disable=SC2089
new_vhost="\n\n
<VirtualHost *:80> \n
      DocumentRoot '$project_dir/$path_origin/public' \n
      ServerName $host_url \n
      ServerAlias $host_url \n
      <Directory '$project_dir/$path_origin/public'> \n
         AllowOverride All \n
         Require all Granted \n
     </Directory> \n
</VirtualHost>"
echo -e $new_vhost >>$apache_dir

echo "Reinicie o seu apache!"

echo "O projeto vai estar rodando em: http://$host_url"

echo "### Fim da instalação ###"
