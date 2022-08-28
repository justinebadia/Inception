# Inception
Ce projet a pour but d'approfondir vos connaissances en vous faisant utiliser Docker. Vous aller virtualiser plusieurs images Docker en les créant dans une machine virtuelle.

## Qu'est ce qu'un conteneur ? 
Les conteneurs sont des enveloppes virtuelles qu'on va créer à l'intérieur de notre ordinateur. Les conteneurs fonctionnent sur le même principe que les machines virtuelles. Ce sont des instances créées sur votre machine qui vont s'isoler du reste de celle-ci pour faire tourner le code. 

Les conteneurs sont utilisés pour leur portabilité : 
 - ils sont **auto-porteurs**, ce qui signifie que leur stabilité est assuré quelque soit l'environnement;
 - ils sont **auto-documentés**, ce qui signifie que leur documentation est intégrée via le fichier de configuration nécessaire à son fonctionnement.
 
Le conteneur permet de faire de la **virtualisation légère**, il ne virtualise pas les ressources (il les partage avec le système hôte), il ne crée qu'une isolation des processus.

**Conteneur stateful**: le conteneur stocke un état (ex une base de données).

**Conteneur stateless**: le conteneur ne stocke pas d'état (ex protocole http).

**Conteneur immuable**: un conteneur ne doit pas stocker de données qui doivent être pérennes, car il les perdra. Pour mettre une base de données en local dans un conteneur Docker, il faut créer un volume pour que celui-ci puisse stocker les données.

## Commandes de base
`docker images` liste les images disponibles sur notre ordinateur;

`docker ps` liste les conteneurs disponibles sur notre ordinateur;

`docker pull <image>` télécharge, depuis un dossier existant ou depuis le docker hub, une image existante;

`docker run -it <image>` pour faire tourner le container de l'image en mode interactif.

`docker run -it -d <image>` pour faire tourner le container de l'image en mode intéractif et détaché, c'est à dire en arrière plan (le container reste "allumé" jusqu'à l'arrêt du service qu'il contient).

`docker stop` <container_id> pour arrêter le container.

![image](https://user-images.githubusercontent.com/79991066/187088766-f79bd1a5-4193-4167-a50e-71b7d64addbf.png)


## Daemon Docker
Lorsqu'on utilise la commande `docker run`, le **daemon Docker** va chercher si l'image est disponible en local, si non, il va la récupérer sur la registry Docker officielle.


 
