NAME = inception 

COMPOSE = docker-compose -f srcs/docker-compose.yml

all: up

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

re: fclean all

.PHONY: all up down start clean fclean re