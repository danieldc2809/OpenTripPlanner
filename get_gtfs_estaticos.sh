#!/bin/bash

#Directorios
DATA_DIR="buenosaires"
BKP_DIR="backups"

#set variables
GTFS=(colectivos trenes subtes)
UPDATERS=(tripUpdates,serviceAlerts)

#API
API_TRANSPORTE="http://apitransporte.buenosaires.gob.ar"
CLIENT_ID="7fb08eb5fe5948dd868efe367f598f6d"
CLIENT_SECRET="322F948f8D3B4400B447e6D0830a19Da"

# se crean los directorios si no existen
mkdir -p "$DATA_DIR"
mkdir -p "$BKP_DIR"


#Se hace backup de cada GTFS
fecha=$(date +"%Y%m%d")
cd $DATA_DIR
for gtfs in *.zip; do
  mv "$gtfs" "../$BKP_DIR/${fecha}_$gtfs"
done
cd ..

#Se descargan los nuevos GTFS
for f in "${GTFS[@]}"
do
    echo "descargando gtfs estatico de $f ......"
    wget "$API_TRANSPORTE/$f/feed-gtfs?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET" -O "$DATA_DIR/$f.zip"
done