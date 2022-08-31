#!/bin/bash
set -euo pipefail #voir help set

unzip wordpress-6.0.2-fr_CA.zip

#Puisqu'il faut attendre que MariaDB soit setup pour lancer WordPress, 
#on envoie des requêtes bidons à la BD, le temps qu'elle se setup
for i in {30..0}; do
    if mysql -u$MYSQL_USER -p$MYSQL_ROOT_PASS --database=$MYSQL_DATABASE_NAME <<<'SELECT 1' &> /dev/null; then
        break
    fi 
        sleep 1
done
if [ $i = 30 ]
    echo "Cannot connect to databse"
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
#generates a wp-config.php file
wp config create --dbname=$MYSQL_DATABASE_NAME \
				 --dbuser=$MYSQL_USER \
				 --dbpass=$MYSQL_PASS \
				 --dbhost=mariadb 
				 --path="var/www/html"
				 --dbcollate="utf8_general_ci"
#creates the WordPress tables in the databases using the default details provided
wp core install --url=$DOMAINE \
				--title="My WordPress" \
				--admin_user=$WP_ADMIN \
				--admin_password=$WP_ADMIN_PASS \
				--admin_email=$WP_ADMIN_EMAIL \
				--skip-email
				--path="var/www/html"
#creates a new user
wp user create $WP_USER $WP_U_EMAIL \
			   --role=editor \
			   --user_pass=$WP_U_PASS \
			   --path="/var/www/html" 
			   
#creates admin user ou utiliser wp super-admin?
wp user create $WP_ADMIN $WP_ADMIN_EMAIL \
			   --role=administrator \
			   --user_pass=$WP_ADMIN_PASS \
			   --path="/var/www/html" 

#ou aller télécharger le theme et le mettre dans les tools puis le copier dans le container
wp theme install astra --activate

fi

exec "$@"