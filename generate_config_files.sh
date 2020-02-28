#!/bin/bash

#API
API_TRANSPORTE="https://apitransporte.buenosaires.gob.ar"
CLIENT_ID="7fb08eb5fe5948dd868efe367f598f6d"
CLIENT_SECRET="322F948f8D3B4400B447e6D0830a19Da"

read -r -p "Este script va a generar los json de configuración necesarios para correr OTP, si ya existen van a ser pisados ..., Estás seguro? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    
echo "Generando builder-config.json"
cat <<EOF > buenosaires/builder-config.json
 {
	"parentStopLinking": true,
	"subwayAccessTime": 2.0
 }
EOF

echo "Generando router-config.json"
cat <<EOF > buenosaires/router-config.json
 {
     //"useFlexService": true,
     "routingDefaults":{
	 "walkSpeed":2.0,
	 "numItineraries":15,
	 "stairsReluctance": 4.0,
         "carDropoffTime": 240,
         "waitAtBeginningFactor": 0.3,
         "maxWalkDistance": 2200,
	 "useBikeRentalAvailabilityInformation": true,
	 "useTraffic": true
     },
    "updaters":[
         {
	  "type": "real-time-alerts",
          "frequencySec": 60,
          "url": "$API_TRANSPORTE/subtes/serviceAlerts?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET",
          "earlyStartSec": 1800,
          "feedId": "1"
         },
        {
	  "type": "stop-time-updater",
           "frequencySec": 60,
           "sourceType": "gtfs-http",
           "url": "$API_TRANSPORTE/colectivos/tripUpdates?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET",
           "feedId": "2"
         },
        {
	   "type": "real-time-alerts",
           "frequencySec": 60,
           "url": "$API_TRANSPORTE/colectivos/serviceAlerts?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET",
           "earlyStartSec": 1800,
           "feedId": "2"
	 },
	{
	    "type": "stop-time-updater",
            "frequencySec": 60,
            "sourceType": "gtfs-http",
            "url": "$API_TRANSPORTE/trenes/tripUpdates?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET",
            "feedId": "3"
	  },
	 {
	    "type": "real-time-alerts",
             "frequencySec": 60,
             "url": "$API_TRANSPORTE/trenes/serviceAlerts?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET",
             "earlyStartSec": 1800,
             "feedId": "3"
	  },    
         {
	    "type": "bike-rental",
            "networks": "GBFS",
            "sourceType": "gbfs",
            "frequencySec": 60,
            "url": "$API_TRANSPORTE/ecobici/gbfs/"
	  }
	 ]
}
EOF
echo "Listo! "
else
    echo " chau, será la próxima ..."
	exit
fi

