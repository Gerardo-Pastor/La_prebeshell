#!/bin/bash

# Script que muestra la iformacion del sistema en que se esta manejando el bash.
#INFOSYS
az="\e[1;34m"
r="\e[0m"
#Primero realizamos la busqueda en nuestro equipo real y los guardamos en variables. 
memTotal=`cat /proc/meminfo | grep "MemTotal" | grep "[1-9].*" -o`
memLibre=`cat /proc/meminfo | grep "MemFree" | grep "[1-9].*" -o`
memSwap=`cat /proc/meminfo | grep "SwapTotal" | grep "[1-9].*" -o`
kernel=`cat /proc/version | awk {'print $3$4'}`
Procesador=`cat /proc/cpuinfo | grep "model name"`

echo -e "A continuacion se presenta la informacion del sistema papu :v:"
echo -e "Memoria libre: $green "$memTotal" $r"
echo -e "Memoria total: $green "$memLibre" $r"
echo -e "Memoria swap total: $green "$memSwap" $r"
echo -e "El tipo de sistema operativo es: $az`cat /proc/sys/kernel/ostype`$r"
echo -e "La distribución del sistema es: $az`cat /proc/version_signature`$r"
echo -e "La versión del kernel es: $az $kernel $r"
echo -e "El modelo del procesador es:"
echo -e "$az $Procesador $r"

for i in $(cat /proc/cpuinfo | grep "cpu MHz" | awk {'print $4$5'}); do
	echo -e "Velocidad del procesador: $az $i [MHz]$r"
done


for i in $(cat /proc/cpuinfo | grep "cache size" | awk {'print $4$5$6'}); do
	echo -e "Memoria caché: $az $i $r"
done






#CREDITOS 
azul="\E[34m\E[1m"
rojo="\E[31m\E[1m"
amarillo="\E[33m\E[1m"
verde="\E[37m\E[32m\E[1m"

echo -e "\n\t\tLa Prebeshell "
echo -e "${rojo}Hecho por:"
echo -e "\t${azul}Jose Alejandro Montecillo Sandoval \n\tGerardo Pastor\n"