#!/bin/bash

#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BUNDLE_DIR="$SCRIPTPATH/bundle"
OBA_DIR="$SCRIPTPATH/app"
GTFS_DIR="$SCRIPTPATH/../buenosaires"


echo "Este script va a borrar y volver a crear el contenido de la carpeta bundle a partir del gtfs de colectivos"
read -r -p "Esto debería correrse cuando se instala por primera vez o si se actualizó el GTFS ..., Estás seguro? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
   rm -rf "$BUNDLE_DIR"/*
   /usr/bin/docker run -it --rm --name oba_build_bundle -v "$GTFS_DIR":/data -v "$BUNDLE_DIR":/bundle -v "$OBA_DIR":/app -w /app maven:3.6.3-jdk-8 java -Xmx8G -server -jar /app/onebusaway-transit-data-federation-builder/target/onebusaway-transit-data-federation-builder-2.0.0-withAllDependencies.jar /data/colectivos.zip /bundle     
else
    echo " ok, se dejan la carpeta como está ..."
	exit
fi



