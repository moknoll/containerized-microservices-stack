NAME = inception 

COMPOSE = docker-compose -f srcs/docker-compose.yml

DATA_PATH = /home/$(USER)/data

all: folders up

folders: 
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress


up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

clean:
	$(COMPOSE) down --volumes --remove-orphans

fclean: down
	docker system prune -a --volumes -f
	sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all up down start clean fclean re folders