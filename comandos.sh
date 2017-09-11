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


#BUSCAR 
amarillo="\e[1;33m"
rojo="\e[1;31m"
azul="\E[34m\E[1m"
reset="\e[0m"

echo -e "$azul Introduce el nombre de un archivo que quieras buscar : $reset"
read arch
echo -e "$azul Introduce la ruta en la que quieres buscar ese arhchivo: $reset" 
read rut

if ls $rut | egrep -ow $arch
then
	echo -e "$amarillo Sí existe el archivo en la ruta especificada $reset"
else
	echo -e "$rojo No hay ningun archivo con ese nombre , no existe $reset"
fi


#FECHA
azul="\e[34m"
reset="\e[0m"
echo -n -e "$azul La fecha actual es: $reset"
cat /proc/driver/rtc | egrep -o -m 1 [0-9]{4}+"-"+[0-9]{2}+"-"+[0-9]{2}

#HORA

rojo="\e[1;31m"
reset="\e[0m"

echo -n -e "$rojo La hora actual es: $reset";
cat /proc/driver/rtc | egrep -o -m 1 [0-9]{2}+":"+[0-9]{2}+":"+[0-9]{2}


#CREDITOS 
azul="\E[34m\E[1m"
rojo="\E[31m\E[1m"
amarillo="\E[33m\E[1m"
verde="\E[37m\E[32m\E[1m"

echo -e "\n\t\tLa Prebeshell "
echo -e "${rojo}Hecho por:"
echo -e "\t${azul}Jose Alejandro Montecillo Sandoval \n\tGerardo Pastor\n"