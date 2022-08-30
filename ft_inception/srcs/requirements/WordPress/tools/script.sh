#!/bin/bash
set -euo pipefail #voir help set

unzip wordpress-6.0.2-fr_CA.zip

for i in {30..0}; do
    if mysql -u$MYSQL_USER -p$MYSQL_ROOT_PASS --database=$MYSQL_DATABASE_NAME <<<'SELECT 1' &> /dev/null; then
        break
    fi 
        sleep 1
done
if [ $i = 30 ]
    echo "Cannot connect to databse"
fi





wp theme install astra --activate