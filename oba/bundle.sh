#!/bin/bash

# IMPORTANTE
# este script no anda, por alguna razon el resultado no es el mismo que corriendo docker-compose up build-bundle
# Lo dejo por las dudas

#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd

echo "este script ya no se usa, generar el bundle corriendo docker-compose up build-bundle"
exit

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BUNDLE_DIR="$SCRIPTPATH/bundle"
OBA_DIR="$SCRIPTPATH/app"
GTFS_DIR="$SCRIPTPATH/../buenosaires"

echo "Este script va a borrar y volver a crear el contenido de la carpeta bundle a partir del gtfs de colectivos"
read -r -p "Correr esto cuando se instala por primera vez o si se actualizó el GTFS, Estás seguro? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    if [[ "$(docker images -q onebusaway-ba:dev 2> /dev/null)" == "" ]]; then
        echo " ERROR: primero es necesario construir la imagen de onebusaway-ba:dev "
        echo " Correr esto: docker-compose build oba "
	    exit
    else        
        rm -rf "$BUNDLE_DIR"/*
        /usr/bin/docker run -it --rm --name oba_build_bundle -v "$GTFS_DIR":/data -v "$BUNDLE_DIR":/bundle -v "$OBA_DIR":/app -w /app onebusaway-ba:dev java -Xss10m -Xmx10G -jar /app/onebusaway-transit-data-federation-builder-2.0.0-withAllDependencies.jar /data/colectivos.zip /bundle
    fi
   
else
    echo " ok, se dejan la carpeta como está ..."
	exit
fi