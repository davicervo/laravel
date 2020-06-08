# Criação e Atualização de projeto
Script criado para auxiliar a criação de projetos em ambientes Windows que utilizam XAMPP, padronizando a forma de criação de vhost e hosts no windows.
E para o dia a dia um script de atualização do projeto, executando alguns comandos necessários para o laravel.

## sh_start_project.sh
- git chekout develop
- composer install
- composer dumpautoload
- php artisan key:generate
- create host Windows
- create vHost no Apache

Atenção: É necessário reiniciar o apache para reconhecer o novo vHost.

## sh_update_project.sh
- git pull
- php artisan cache:clear
- php artisan migrate
- cp .env .env.backup
- rm .env
- cp .env.localhost .env

Atenção: Na criação do projeto é necessário criar um arquivo .env.localhost que será usado entre os desenvolvedores no desenvolvimento do projeto e esse arquivo deve ser versionado, com isso o .env em desenvolvimento sempre será o mesmo para todos os desenvolvedores. Por segurança um backup da última versão do .env local é gerado toda vez que o script é executado, este arquivo não deve ser versionado.
