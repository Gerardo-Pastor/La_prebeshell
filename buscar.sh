#!/bin/bash
#Este es el script para buscar en una ruta especifica del ordenador 

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