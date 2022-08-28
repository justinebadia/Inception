# Inception
Ce projet a pour but d'approfondir vos connaissances en vous faisant utiliser Docker. Vous aller virtualiser plusieurs images Docker en les créant dans une machine virtuelle.

## Qu'est ce qu'un conteneur ? 
Les conteneurs sont des enveloppes virtuelles qu'on va créer à l'intérieur de notre ordinateur. Les conteneurs fonctionnent sur le même principe que les machines virtuelles. Ce sont des instances créées sur votre machine qui vont s'isoler du reste de celle-ci pour faire tourner le code. 

Les conteneurs sont utilisés pour leur portabilité : 
 - ils sont **auto-porteurs**, ce qui signifie que leur stabilité est assurée quelque soit l'environnement;
 - ils sont **auto-documentés**, ce qui signifie que leur documentation est intégrée via le fichier de configuration nécessaire à son fonctionnement.
 
Le conteneur permet de faire de la **virtualisation légère**, il ne virtualise pas les ressources (il les partage avec le système hôte), il ne créait qu'une isolation des processus.

**Conteneur stateful**: le conteneur stocke un état (ex une base de données).

**Conteneur stateless**: le conteneur ne stocke pas d'état (ex protocole http).

**Conteneur immuable**: un conteneur ne doit pas stocker de données qui doivent être pérennes, car il les perdra. Pour mettre une base de données en local dans un conteneur Docker, il faut créer un volume pour que celui-ci puisse stocker les données.

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

**`FROM`** - va télécharger une image de base pour notre container (ex: alpine:3.14)

**`ADD`** - pour copier ou télécharger des fichiers dans l'image. 

**`WORKDIR`** - pour modifier le répertoire courant, donc l'ensemble des commandes qui suivront seront exécutées depuis le répertoire défini par WORKDIR.

**`RUN`** - pour exécuter une commande dans notre container.

**`EXPOSE`** - permet d'indiquer le port sur lequel notre app écoute.

**`VOLUME`** - permet d'indiquer quel répertoire nous voulons partager avec notre hôte

**`CMD`** - permet au container de savoir quelle commande il doit exécuter à son démarrage.


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

**`services`** - pour définir les différents containers qui vont tourner en même temps; Pour chaque service, il faut définir l'image à utiliser, et spécifier les ports. 

![image](https://user-images.githubusercontent.com/79991066/187093881-0e112bac-96ef-4582-be97-9aa530ed08ec.png)






 
