#!/bin/bash

# Definindo variáveis
VERSION_PROJECT="0.0.1-SNAPSHOT"

#DESAFIO API
PROJECT_DIR_DESAFIO_API="desafio" 
PROJECT_NAME_DESAFIO_API="desafio-api"
DOCKER_IMAGE_NAME_DESAFIO_API="desafio-api"  

#DB-LISTENER-FILE-CREATION
PROJECT_DIR_DB_LISTENER="db-listener-file-creation" 
PROJECT_NAME_DB_LISTENER="db-listener-file-creation"
DOCKER_IMAGE_NAME_DB_LISTENER="db-listener"  

# Passo 1: Entrar na pasta do projeto desafio-api
echo "Iniciando script de setup"
cd "$PROJECT_DIR_DESAFIO_API" || exit

mvn -N io.takari:maven:wrapper

# Passo 2: Construir a imagem Docker desafio-api
echo "Construindo a imagem Docker desafio-api..."
if docker build -t "$DOCKER_IMAGE_NAME_DESAFIO_API" .; then
    echo "A imagem Docker $DOCKER_IMAGE_NAME_DESAFIO_API foi construída com sucesso."
else
    echo "Falha ao construir a imagem Docker."
    exit 1
fi

# Retornar para o diretório anterior
cd ..

# Passo 3: Entrar na pasta do db-listener
cd "$PROJECT_DIR_DB_LISTENER" || exit

mvn -N io.takari:maven:wrapper

# Passo 4: Construir a imagem Docker db-listener
echo "Construindo a imagem Docker db-listener..."
if docker build -t "$DOCKER_IMAGE_NAME_DB_LISTENER" .; then
    echo "A imagem Docker $DOCKER_IMAGE_NAME_DB_LISTENER foi construída com sucesso."
else
    echo "Falha ao construir a imagem Docker."
    exit 1
fi

cd ..
# Passo 5: Executar docker compose
echo "Executando docker compose para deixar tudo pronto"
docker-compose up
