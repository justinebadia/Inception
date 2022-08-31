#!/bin/bash

set -euo pipefail #voir help set
dataDB=/var/lib/mysql/init_dataDB.sql

#chown -R $MYSQL_USER: $dataDB
if [ ! -f $dataDB ]
then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null
    cat > $dataDB <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';
FLUSH PRIVILEGES;
EOF
    # &pour lancer en background
    mysqld --skip-networking &
    #J'envoie des requêtes bidons jusqu'a ce que ma base de données soit prête a accepter des requêtes, 
    #donc qu'il puisse executer mon script initdataDB.sql
    for i in {30..0}; do
        if mysql --user=root --password=$MYSQL_ROOT_PASS --database=mysql <<<'SELECT 1' &> /dev/null; then
            break
        fi 
        sleep 1
    done
    if [ "$i" = 0 ]; then
        exit 1
    fi
    mysql --user=root --password=$MYSQL_ROOT_PASS < $dataDB && killall mysqld
fi

exec "$@"

