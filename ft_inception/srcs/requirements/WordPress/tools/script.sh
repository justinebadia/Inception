#!/bin/bash
set -euo pipefail #voir help set

#Puisqu'il faut attendre que MariaDB soit setup pour lancer WordPress, 
#on envoie des requêtes bidons à la BD, le temps qu'elle se setup
for i in {0..30}; do
    if mariadb -hmariadb -u$MYSQL_USER -p$MYSQL_PASS --database=$MYSQL_DATABASE_NAME <<<'SELECT 1;' &> /dev/null; then
        break
    fi 
        sleep 1
done

if [ "$i" = 30 ]; then
    echo "Cannot connect to databse"
    exit 1
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
    unzip "wordpress-6.0.2-fr_CA.zip" >/dev/null
    mv wordpress/ html/
    #generates a wp-config.php file
    wp config create --allow-root \
                    --dbname=$MYSQL_DATABASE_NAME \
                    --dbuser=$MYSQL_USER \
                    --dbpass=$MYSQL_PASS \
                    --dbhost=mariadb \
                    --dbcollate="utf8_general_ci" \
                    --path="/var/www/html" 
    #creates the WordPress tables in the databases using the default details provided
    wp core install  --allow-root \
                    --title="My WordPress" \
                    --url="$DOMAINE" \
                    --admin_name="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASS" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --skip-email \
                    --path="/var/www/html" 

    #creates a new user
    wp user create $WP_USER \
                   $WP_U_EMAIL \
                --allow-root \
                --role=editor \
                --user_pass=$WP_U_PASS \
                --path="/var/www/html" 
                
    #ou aller télécharger le theme et le mettre dans les tools puis le copier dans le container
fi

exec "$@"
