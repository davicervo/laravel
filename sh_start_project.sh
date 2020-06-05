#inciando o projeto
#git checkout develop
#git pull
#composer install
#cp .env.localhost .env
#composer dumpautoload
#php artisan key:generate

#host do windows

#vhosts
host_url=api_form_cci
project_dir=$(pwd)
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
cd /d/xampp
start apache_stop.bat
start apache_start.bat
