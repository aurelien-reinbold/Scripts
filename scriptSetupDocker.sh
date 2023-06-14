#!/bin/bash

# Maxime ROLLAND - 26/05/2023
# Source : https://docs.docker.com/engine/install/debian/#prerequisites
# Script de déploiement de docker sur une installation vierge de Debian 11
# A executer en Sudo

# check if user is root
if [ ! "$(whoami)" = "root" ];
then
	echo "Ce script doit être executé avec les privilèges root";
	exit
fi

#Set up the repository

apt-get update
apt-get install ca-certificates curl gnupg -y

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" > /etc/apt/sources.list.d/docker.list

# Install docker Engine
apt-get update
apt-get install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

docker run hello-world

if [ ! -z $1 ];
then
	adduser $1 docker
fi
