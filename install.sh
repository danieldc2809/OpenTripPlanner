#!/bin/bash

# referencia: https://codefresh.io/docker-tutorial/java_docker_pipeline/

OTP_DIR=opentripplanner
OTP_REPO=https://repositorio-asi.buenosaires.gob.ar/ssppbe_usig/opentripplanner.git

echo "1) Instalando OTP"
if [[ -d "$OTP_DIR" ]]
then
    echo "* La carpeta $DIRECTORY ya existe, entonces se omite el paso del git clone"
else
    echo "* No existe el directorio $OTP_DIR entonces se clona el repo"
    echo "WARNING: este script esta pensado para levantar el branch master, para levantar otro branch o tag hay que modificar el script"    
    git clone "$OTP_REPO"
fi

echo "2) Se descargan los GTFS de la api transporte"
./get_gtfs_estaticos.sh
EXIT_CODE=$?

if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al descargar los gtfs"
  exit 1
fi

echo "3) Se construye el pbf desde la base osm_gba de 10.9.6.110 (ver accesos del pg_hba)"
./get_pbf.sh
EXIT_CODE=$?

if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al construir pbf"
  exit 1
fi

echo "4) Se crean los archifos de config de OTP"
./generate_config_files.sh
EXIT_CODE=$?

if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al crear archivos de configuracion"
  exit 1
fi

echo "5) Se hace el build del jar"
docker run -it --rm --name otp_build_project -v "$PWD/$OTP_DIR":/usr/src/app -w /usr/src/app maven:3.6.3-jdk-8 mvn clean package -Dmaven.test.skip=true

EXIT_CODE=$?

if [ $EXIT_CODE -gt 0 ] ; then
  echo "No se pudo crear el jar ... ver que onda"
  exit 1
fi

echo "6) Se construye el grafo"
docker run -it --rm --name otp_build_grafo -v "$PWD/buenosaires":/grafo -v "$PWD/$OTP_DIR":/usr/src/app -w /usr/src/app maven:3.6.3-jdk-8 java -Xmx4G -jar target/otp-1.5.0-SNAPSHOT-shaded.jar --build /grafo

echo "Listo, ya se puede correr docker-compose up !"
