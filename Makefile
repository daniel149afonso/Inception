# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: daafonso                                   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/15                              #+#    #+#              #
#    Updated: 2026/06/15                             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Nom du projet
NAME = inception

# Emplacement du fichier docker-compose.yml
COMPOSE = docker compose -f srcs/docker-compose.yml

# Cible exécutée lorsque l'on tape simplement "make"
all: up

# ---------------------------------------------------------------------------- #
# Crée les dossiers utilisés par les volumes persistants
# puis construit et démarre les conteneurs en arrière-plan
# ---------------------------------------------------------------------------- #
up:
	mkdir -p /home/daafonso/data/mariadb
	mkdir -p /home/daafonso/data/wordpress
	$(COMPOSE) up -d --build

# ---------------------------------------------------------------------------- #
# Arrête et supprime les conteneurs ainsi que le réseau Docker
# Les volumes sont conservés
# ---------------------------------------------------------------------------- #
down:
	$(COMPOSE) down

# ---------------------------------------------------------------------------- #
# Arrête les conteneurs sans les supprimer
# ---------------------------------------------------------------------------- #
stop:
	$(COMPOSE) stop

# ---------------------------------------------------------------------------- #
# Redémarre des conteneurs déjà existants
# Sans reconstruction des images
# ---------------------------------------------------------------------------- #
start:
	$(COMPOSE) start

# ---------------------------------------------------------------------------- #
# Redémarrage complet du projet
# ---------------------------------------------------------------------------- #
restart: down up

# ---------------------------------------------------------------------------- #
# Affiche les logs des services en temps réel
# ---------------------------------------------------------------------------- #
logs:
	$(COMPOSE) logs -f

# ---------------------------------------------------------------------------- #
# Affiche l'état des conteneurs du projet
# ---------------------------------------------------------------------------- #
ps:
	$(COMPOSE) ps

# ---------------------------------------------------------------------------- #
# Supprime les conteneurs et les volumes du projet
# Attention : les données WordPress et MariaDB seront supprimées
# ---------------------------------------------------------------------------- #
clean:
	$(COMPOSE) down -v

# ---------------------------------------------------------------------------- #
# Nettoyage complet de Docker
# Supprime :
# - les images inutilisées
# - les conteneurs inutilisés
# - les volumes inutilisés
# - le cache de build
# ---------------------------------------------------------------------------- #
fclean: clean
	docker system prune -af
	docker volume prune -f

# ---------------------------------------------------------------------------- #
# Reconstruction complète du projet depuis zéro
# ---------------------------------------------------------------------------- #
re: fclean up

# Ces cibles ne correspondent pas à des fichiers
.PHONY: all up down stop start restart logs ps clean fclean re
