#!/bin/bash

#API
API_TRANSPORTE="https://apitransporte.buenosaires.gob.ar"
CLIENT_ID="7fb08eb5fe5948dd868efe367f598f6d"
CLIENT_SECRET="322F948f8D3B4400B447e6D0830a19Da"

docker run -v "$PWD":/usr/src/app -w /usr/src/app maven:3.6.3-jdk-8 java -Xmx2G -server -jar onebusaway-quickstart-assembly-2.0.0-api-webapp.war -webapp bundle
#java -Xmx2G -server -jar onebusaway-quickstart-assembly-2.0.0-api-webapp.war -webapp bundle -gtfsRealtimeAlertsUrl=https://apitransporte.buenosaires.gob.ar/colectivos/serviceAlerts?client_id=7fb08eb5fe5948dd868efe367f598f6d&client_secret=322F948f8D3B4400B447e6D0830a19Da -gtfsRealtimeTripUpdatesUrl=https://apitransporte.buenosaires.gob.ar/colectivos/tripUpdates?client_id=7fb08eb5fe5948dd868efe367f598f6d&client_secret=322F948f8D3B4400B447e6D0830a19Da 
