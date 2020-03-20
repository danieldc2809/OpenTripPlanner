#!/bin/bash

#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
OBA_DIR="$SCRIPTPATH/app"

echo "Este script va a generar/pisar los .war de cada módulo de oba"
read -r -p "Esto debería correrse cuando se instala por primera vez o si se actualizó el código de oba ..., Estás seguro? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    /usr/bin/docker run -it --rm --name oba_mvn_build -v "$OBA_DIR":/app -w /app maven:3-jdk-8 mvn install -D license.skip=true -D maven.test.skip=true     
else
    echo " ok, se dejan los war como están ..."
	exit
fi