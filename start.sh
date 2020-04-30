#!/bin/bash

echo "1) Hay que construir el bundle de oba"
/usr/local/bin/docker-compose -f oba-docker-compose.yml up build-bundle 

EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
  #aparentemente no entra aca cuando hay error del gtfs
  echo "No se pudo crear el bundle de OBA"
  exit 1
fi

echo "2) Se inician OTP y OBA"
/usr/local/bin/docker-compose -f oba-docker-compose.yml up -d oba 
/usr/local/bin/docker-compose -f otp-docker-compose.yml up -d otp
