#!/bin/bash

# En esta version intento descargar los binarios en lugar de compilar todo 


#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
APP_DIR="$SCRIPTPATH/app"

URL=http://nexus.onebusaway.org/nexus/content/groups/public/org/onebusaway
VERSION=2.0.0

FILE_1="$URL/onebusaway-transit-data-federation-builder/$VERSION/onebusaway-transit-data-federation-builder-$VERSION-withAllDependencies.jar"

FILE_2="$URL/onebusaway-transit-data-federation-webapp/$VERSION/onebusaway-transit-data-federation-webapp-$VERSION.war"

FILE_3="$URL/onebusaway-api-webapp/$VERSION/onebusaway-api-webapp-$VERSION.war"

FILE_4="$URL/onebusaway-enterprise-acta-webapp/$VERSION/onebusaway-enterprise-acta-webapp-$VERSION.war"

echo "Descargando binarios del proyecto"

if [[ -d "$APP_DIR" ]]
then
    echo "INFO: Ya existe la carpeta $APP_DIR dentro de oba, por las dudas no se borra así que si se quiere instalar de cero primero hay que borrarla" 
else

    mkdir "$APP_DIR"

    echo "INFO: descargando $FILE_1"
    wget "$FILE_1" -O "$APP_DIR/onebusaway-transit-data-federation-builder-2.0.0-withAllDependencies.jar"    
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al descargar $FILE_1"
      rm -rf "$APP_DIR"
      exit 1
    fi

    echo "INFO: descargando $FILE_2"
    wget "$FILE_2" -O "$APP_DIR/onebusaway-transit-data-federation-webapp.war"    
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al descargar $FILE_2"
      rm -rf "$APP_DIR"
      exit 1
    fi

    echo "INFO: descargando $FILE_3"
    wget "$FILE_3" -O "$APP_DIR/onebusaway-api-webapp.war"    
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al descargar $FILE_3"
      rm -rf "$APP_DIR"
      exit 1
    fi

    echo "INFO: descargando $FILE_4"
    wget "$FILE_4" -O "$APP_DIR/onebusaway-enterprise-acta-webapp.war"    
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
      echo "Error al descargar $FILE_4"
      rm -rf "$APP_DIR"
      exit 1
    fi    

    
fi



echo "INFO: OBA instalado, falta construir el directorio bundle nomás."
