all: up

up: 
	mkdir -p /home/justine/data/mariadb /home/justine/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

build:
	docker compose -f srcs/docker-compose.yml build


