NAME = inception 

COMPOSE = docker-compose -f srcs/docker-compose.yml

UNAME_S := $(shell uname -s)

# Set path for macos or linux
ifeq ($(UNAME_S),Darwin)
    DATA_PATH := /Users/$(USER)/data
else
    DATA_PATH := /home/$(USER)/data
endif

all: folders up

folders: 
	@echo "Setup data folders at: $(DATA_PATH)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

up:
	DATA_PATH=$(DATA_PATH) $(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

clean:
	$(COMPOSE) down --remove-orphans

fclean: down
	docker system prune -a --volumes -f
	sudo rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all up down start clean fclean re folders