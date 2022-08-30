#!/bin/bash

set -euo pipefail #voir help set

mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null

## il faut vérifier s'il y a deja le fichier, sinon on le créait et on y met les commandes
# create database et create user, ensuite il faut changer le mdp du user 
#cat > /var/lib/mysql 

##CREATE DATABASE IF NOT EXIST WordPress;

##CREATE USER DBW for login 

exec "$@"