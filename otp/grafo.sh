#!/bin/bash

OTP_DIR=app
GRAFO_DIR="$PWD/../buenosaires"

read -r -p "Este paso se puede saltear si ya existe uno ¿Generar GRAFO? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    docker run -it --rm --name otp_build_grafo -v "$GRAFO_DIR":/grafo -v "$PWD/$OTP_DIR":/usr/src/app -w /usr/src/app maven:3.6.3-jdk-8 java -Xmx4G -jar target/otp-1.5.0-SNAPSHOT-shaded.jar --build /grafo
else
    echo "INFO: ok, no se crea el GRAFO y se va al siguiente paso ..."	
fi 