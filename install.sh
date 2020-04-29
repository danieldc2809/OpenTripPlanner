#!/bin/bash


echo "Comprobando requerimientos: git, docker y osmosis"
# Requerimiento tener instalado OSMOSIS
if ! [ -x "$(command -v osmosis)" ]; then
    echo 'Error: es necesario instalar OSMOSIS: probar con sudo apt install osmosis' >&2
    exit 1
fi
# Requerimiento tener instalado OSMOSIS
if ! [ -x "$(command -v docker)" ]; then
    echo 'Error: es necesario instalar DOCKER' >&2
    exit 1
fi
# Requerimiento tener instalado GIT
if ! [ -x "$(command -v git)" ]; then
    echo 'Error: es necesario instalar GIT' >&2
    exit 1
fi
echo "INFO: Los requerimientos están ok "

echo " "
echo "----------------------------"
echo " "
echo "1) Instalando OTP (opentripplanner)"
echo " "
./otp/install.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al instalar o buildear OTP"
  exit 1
fi

echo " "
echo "----------------------------"
echo " "
echo "2) Descargando los GTFS de la api transporte"
echo " "
./get_gtfs_estaticos.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al descargar los gtfs"
  exit 1
fi

echo " "
echo "----------------------------"
echo " "
echo "3) Construyendo el PBF de AMBA"
echo " "
./get_pbf.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al construir PBF"
  exit 1
fi

echo " "
echo "----------------------------"
echo " "
echo "4) Se construye el grafo"
echo " "
./otp/grafo.sh
if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al construir el grafo para OTP"
  exit 1
fi

echo " "
echo "----------------------------"
echo " "
echo "5) Instalando OBA (onebusaway)"
echo " "
./oba/install.sh
EXIT_CODE=$?
if [ $EXIT_CODE -gt 0 ] ; then
  echo "Error al instalar OBA"
  exit 1
fi
echo " "
echo "<---------- FIN ------------------>"
echo " "
echo "FIN: si ya está instalado OTP y OBA"
echo "Solo falta generar el bundle de oba e iniciar los servicios"
