#!/bin/bash

#se usa SCRIPTPATH en lugar de pwd porque cuando se ejecuta desde ../install.sh hereda ese pwd
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
OTP_DIR="$SCRIPTPATH/app"

read -r -p "Este paso se puede saltear. ¿Generar JAR? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    /usr/bin/docker run -it --rm --name otp_build_project -v "$OTP_DIR":/usr/src/app -w /usr/src/app maven:3.6.3-jdk-8 mvn clean package -Dmaven.test.skip=true
else
    echo "INFO: ok, no se crea el JAR y se va al siguiente paso ..."	
fi    