#!/bin/bash
echo '### Iniciando atualização dos projetos ??????? e APIs ###'

git pull
php artisan cache:clear
php artisan migrate
cp .env .env.backup
rm .env
cp .env.localhost .env
