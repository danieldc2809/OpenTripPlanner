#!/bin/bash

#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
OTP_DIR="$SCRIPTPATH/app"
OTP_REPO=https://repositorio-asi.buenosaires.gob.ar/ssppbe_usig/opentripplanner.git

if [[ -d "$OTP_DIR" ]]
then
    echo "INFO: La carpeta $DIRECTORY ya existe, entonces se omite el paso del git clone"
else
    echo "INFO: No existe el directorio $OTP_DIR entonces se clona el repo"
    echo "WARNING: este script esta pensado para levantar el branch master, para levantar otro branch o tag hay que modificar el script"    
    git clone "$OTP_REPO" "$OTP_DIR"
    EXIT_CODE=$?
    if [ $EXIT_CODE -gt 0 ] ; then
        exit 1
    fi
fi

echo "INFO: Se va a intentar hacer el build del jar de OTP"
source "$SCRIPTPATH"/build.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
    echo "Error al buildear OTP"
    exit 1
fi    


echo "INFO: Se va a intentar crear los archivos de config de OTP"
source "$SCRIPTPATH"/generate_config_files.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
    echo "Error al crear los archivos de configuración de OTP"
    exit 1
fi