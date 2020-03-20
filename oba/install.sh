#!/bin/bash

TAG=onebusaway-application-modules-2.0.0
REPO=https://github.com/OneBusAway/onebusaway-application-modules.git
#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
APP_DIR="$SCRIPTPATH/app"

echo "Descargando proyecto"
if [[ -d "$APP_DIR" ]]
then
    echo "INFO: Ya existe la carpeta $APP_DIR dentro de oba, por las dudas no se borra así que si se quiere instalar de cero primero hay que borrarla" 
else
    echo "INFO: clonando tag $TAG dentro de la carpeta $APP_DIR"    
    git clone --depth 1 --branch "$TAG" "$REPO" "$APP_DIR"
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al clonar el repo, no se puede continuar"
      exit 1
    fi

    echo "INFO: Construir los módulos, es decir generar los .war (build de maven)"
    source "$SCRIPTPATH/build.sh"
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al contruir los .war de los módulos, se puede ejecutar directamente build.sh para no volver a correr lo anterior"
      exit 1
    fi

    echo "INFO: Construir el directorio bundle (a partir del GTFS)"
    source "$SCRIPTPATH/bundle.sh"
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al contruir el bundle (seguramente bardeó el GTFS)"
      echo "se puede ejecutar directamente bundle.sh para no volver a correr lo anterior"
      exit 1
    fi
fi



echo "Listo! con esto ya se podria correr oba por medio del servicio oba del docker-compose"