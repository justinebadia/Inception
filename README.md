# Inception 🐳
Ce projet a pour but d'approfondir vos connaissances en vous faisant utiliser Docker. Vous aller virtualiser plusieurs images Docker en les créant dans une machine virtuelle.

## Qu'est ce qu'un conteneur ? 
Les conteneurs sont des enveloppes virtuelles qu'on va créer à l'intérieur de notre ordinateur. Les conteneurs fonctionnent sur le même principe que les machines virtuelles. Ce sont des instances créées sur votre machine qui vont s'isoler du reste de celle-ci pour faire tourner le code. 

Les conteneurs sont utilisés pour leur portabilité : 
 - ils sont **auto-porteurs**, ce qui signifie que leur stabilité est assurée quelque soit l'environnement;
 - ils sont **auto-documentés**, ce qui signifie que leur documentation est intégrée via le fichier de configuration nécessaire à leur fonctionnement.
 
Le conteneur permet de faire de la **virtualisation légère**, il ne virtualise pas les ressources (il les partage avec le système hôte), il ne créait qu'une isolation des processus.

**Conteneur stateful**: le conteneur stocke un état (ex une base de données).

**Conteneur stateless**: le conteneur ne stocke pas d'état (ex protocole http).

**Conteneur immuable**: un conteneur ne doit pas stocker de données qui doivent être pérennes, car il les perdra. Pour mettre une base de données en local dans un conteneur Docker, il faut créer un **volume** pour que celui-ci puisse stocker les données.

## Commandes de base
`docker images` - liste les images disponibles sur notre ordinateur;

`docker ps` - liste les containers disponibles sur notre ordinateur;

`docker pull <image>` - télécharge, depuis un dossier existant ou depuis le docker hub, une image existante;

`docker run -it <image>` - pour faire tourner le container de l'image en mode interactif. Lorsqu'on utilise la commande `docker run`, le **daemon Docker** va chercher si l'image est disponible en local, si non, il va la récupérer sur la registry Docker officielle.

`docker run -it -d <image>` - pour faire tourner le container de l'image en mode intéractif et détaché, c'est à dire en arrière plan (le container reste "allumé" jusqu'à l'arrêt du service qu'il contient).

`docker stop <container_id>`- pour arrêter le container.

![image](https://user-images.githubusercontent.com/79991066/187088766-f79bd1a5-4193-4167-a50e-71b7d64addbf.png)

`docker exec -ti <container_ID> bash` - ouvre un shell bash qui nous permet de "rentrer" dans le container et d'y effectuer des actions.

`docker rm <container_ID>`- pour supprimer le container et son contenu. 

`docker system prune` - pour supprimer l'ensemble des containers qui ne sont pas en status running, l'ensemble des réseaux créés par Docker et qui ne sont pas utilisés par au moins un container, l'ensemble des images Docker non utilisées, l'ensemble des caches utilisés pour la création d'images Docker.


## Dockerfile
Chaque instruction donnée dans le Dockerfile va créer une nouvelle layer correspondant à chaque étape de la construction de l'image. Pour que l'image soit la plus légère et performante possible, notre but est de limiter le nombre de layer.

### Éléments du Dockerfile

**`FROM`** - permet de définir l'image source pour notre container (ex: alpine:3.14)

**`ADD`** - pour ajouter des fichiers dans notre container. 

**`WORKDIR`** - pour modifier le répertoire courant, donc l'ensemble des commandes qui suivront seront exécutées depuis le répertoire défini par WORKDIR.

**`RUN`** - pour exécuter une commande dans notre container.

**`EXPOSE`** - permet de définir le port d'écoute par défait.

**`VOLUME`** - permet de définir les volumes utilisables.

**`ENTRYPOINT`** - permet de spécifier une commande qui sera exécutée au démarrage du container.

**`CMD`** - si utilisé avec entrypoint, permet de donner des arguments par défaut au entrypoint.


Pour construire l'image `docker build -t <nom_de l'image> <dossier ou créer l'image>`

![image](https://user-images.githubusercontent.com/79991066/187090173-5999bc72-33e8-45f6-ba49-64b88b233d25.png)

## Docker Compose

Docker Compose permet de décrire, dans un fichier yml, plusieurs conteneurs comme un ensemble de services. 

### Commandes
`docker-compose pull` - pour récupérer l'ensemble des images décrites dans notre fichier docher-compose.yml.

`docker-compose up [-d]` - pour lancer la création de l'ensemble des containers (= une stack Docker Compose).

`docker-compose ps` - qui permet de svoir le statut de l'ensemble de notre stack.

`docker-compose logs -f --tail 5` - permet de voir les logs sur les différents containers, en se limitant aux 5 premières lignes.

`docker-compose stop` - permet d'arrêter une stack Docker Compose, mais ne supprime pas les ressources créées par la stack. Donc si on relance avec `docker-compose up -d` l'ensemble de notre stack sera tout de suite fonctionnel.

`docker-compose down` - pour supprimer l'ensemble de la stack, y compris les ressources créées.

`docker-compose config` - permet de valider la syntaxe du fichier.

### Élements du Docker Compose
**`version`** - pour spécifier la version utilisée;

**`services`** - pour définir les différents containers qui vont tourner en même temps. Pour chaque service, il faut définir plusieurs éléments:

- l'**`image`** à utiliser ; Au lieu de l'image, on peut spécifier l'argument `build` en lui spécifiant le chemin vers notre Dockerfile, ainsi lors de l'exécution de Docker Compose, il aurait construit le container via le Dockerfile avant de l'exécuter.

- le **`volume`** où stocker les données. Par exemple le volume `db_data` est un volume créé par Docker directement, qui permet d'écrire les données sur le disque hôte sans spécifier l'emplacement exact.

- **`restart`** définit la politique de redémarrage du container (en cas d'erreur fatale par exemple). 

- **`environnement`** pour définir les variables d'environnement.

- **`depends_on`** permet de créer une dépendance entre 2 containers, donc de faire démarrer un container avant l'autre. Par exemple il faut démarrer le service db avant Wordpress car Wordpress dépend de la base de données pour fonctionner.


### MARIADB

**Liens utiles:**

- https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-debian-10#step-2-configuring-mariadb - instalation
- https://developpaper.com/mariadb-mysql-configuration-file-my-cnf-detailed-explanation/ - configuration file
- https://mariadb.com/kb/en/account-management-sql-commands/ - SQL commands
- https://github.com/MariaDB/mariadb-docker/blob/master/docker-entrypoint.sh - mariadb entrypoint


Pour se connecter à la base de données mariadb: 

`mysql -u root -ppassword`-  pour se connecter à la BD;

`show databases` -  pour voir les bases de données;

`use <database_name>` - 

`show tables` - 

`SELECT <column_name> from <table_name>` (ex: SELECT user,password from user;) - pour afficher les informations demandées;


### WORDPRESS

**Installation**

Pour WordPress, il faut installer WP-CLI :
https://wp-cli.org/fr/#installation . Pour vérifier que l'installation a bien fonctionné -> `wp --info`

Télécharger WordPress : https://fr-ca.wordpress.org/download/ . Puis copier le dossier zippé dans votre container, il faudra le unzip dans le script.

Pour créer le `wp-config.php` -> `wp config create` - (https://developer.wordpress.org/cli/commands/config/create/)

Pour créer la table WordPress -> `wp core install` - (https://developer.wordpress.org/cli/commands/core/install/)

Pour créer le second user -> `wp user create` - (https://developer.wordpress.org/cli/commands/user/create/)


### NGINX

Se connecter au container Nginx en téléchargeant l'image officielle depuis le Docker Hub:

```
sudo docker run -d --name nginx-base -p 80:80 nginx:latest
```

Puis se rendre dans le dossier `/etc/nginx/conf.d` pour faire un cat du file `default.conf` pour l'insérer dans notre script.sh.

Pour les protocoles TLS: 

Vérifier si openssl est installé sur la VM -> `openssl version` sinon l'installer dans le Dockerfile.
Puis éditer le fichier default.conf en ajoutant:

```bash
 # Path to certs
 ssl_certificate		/etc/nginx/ssl/$CERT_CRT;
	ssl_certificate_key	/etc/nginx/ssl/$CERT_KEY;
	ssl_protocols		TLSv1.2 TLSv1.3;
```

Créer les certificats dans le dossier conf de la VM, afin d'aller les copier par la suite dans le container via le Dockerfile.

Pour créer le **certificate authority**: `openssl req -x509 -sha256 -days 3650 -nodes -newkey rsa:2048 -subj "/CN=jbadia.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" -keyout CA.key -out CA.crt`

Pour créer la **server private key**: `openssl genrsa -out server.key 2048`

toutes les commandes pour créer les key .... 
modifier le fichier /etc/hosts pour ajouter notre nom de domaine.


jbadia.42.fr/wp-login.php

