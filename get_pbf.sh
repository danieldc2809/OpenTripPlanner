#!/bin/bash

HOST=10.9.6.110
DB=osm_gba
USER=grafo #descarga los datos del esquema del mismo nombre
PWORD=grafo
DIR="buenosaires/"

echo "INFO: Este script va a generar un nuevo archivo amba.pbf desde la base osm_gba en 10.9.6.110 (ver accesos del pg_hba)"
echo "Si ya existe un PBF se lo mueve a la carpeta backups"
read -r -p "Este paso se puede saltear. ¿Generar PBF? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo probando conexión a la BD
    psql -h $HOST -d $DB -U $USER -c "select 'ok' as conection;"
    
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo Fallo en la conexión a la BD
      exit 1
    fi

    echo iniciando descarga grafo en formato PBF $(date)
    osmosis --read-pgsql host=$HOST database=$DB user=$USER password=$PWORD outPipe.0=1 --dataset-dump inPipe.0=1 outPipe.0=2 --write-pbf file=/tmp/amba_$(date +"%Y%m%d").pbf inPipe.0=2

    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo Fallo en la descarga del archivo "/tmp/amba_$(date +"%Y%m%d").pbf"
      exit 1
    fi

    date

    echo "INFO: Haciendo backup del pbf actual"
    mv "$DIR"*.pbf backups/

    echo "INFO: copiando archivo pbf a $DIR"
    mv /tmp/amba_$(date +"%Y%m%d").pbf "$DIR"     
else
    echo " ok, no se crea el PBF y se va al siguiente paso ..."	
fi




