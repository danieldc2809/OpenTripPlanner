#!/bin/bash

HOST=10.9.6.110
DB=osm_gba
USER=grafo #descarga los datos del esquema del mismo nombre
PWORD=grafo
DIR="buenosaires/"


# Requerimiento tener instalado OSMOSIS
if ! [ -x "$(command -v osmosis)" ]; then
    echo 'Error: es necesario instalar OSMOSIS: probar con sudo apt install osmosis' >&2
    exit 1
fi

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

echo "Haciendo backup del pbf actual"
mv "$DIR"*.pbf backups/

echo "copiando archivo pbf a $DIR"
mv /tmp/amba_$(date +"%Y%m%d").pbf "$DIR"

