#!/bin/bash

echo "Parando OTP y OBA"
/usr/local/bin/docker-compose -f oba-docker-compose.yml down 
/usr/local/bin/docker-compose -f otp-docker-compose.yml down
