#!/bin/bash
amarillo="\e[1;33m"
rojo="\e[1;31m"
azul="\e[1;34m"
verde="\e[1;32m"
r="\e[0m"
case $1 in
	"infosys") 
		# Script que muestra la iformacion del sistema en que se esta manejando el bash.
		
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
		echo -e "El tipo de sistema operativo es: $azul`cat /proc/sys/kernel/ostype`$r"
		echo -e "La distribución del sistema es: $azul`cat /proc/version_signature`$r"
		echo -e "La versión del kernel es: $azul $kernel $r"
		echo -e "El modelo del procesador es:"
		echo -e "$azul $Procesador $r"

		for i in $(cat /proc/cpuinfo | grep "cpu MHz" | awk {'print $4$5'}); do
			echo -e "Velocidad del procesador: $azul $i [MHz]$r"
		done


		for i in $(cat /proc/cpuinfo | grep "cache size" | awk {'print $4$5$6'}); do
			echo -e "Memoria caché: $azul $i $r"
		done
	;;
	"busca")
		

		echo -e "$azul Introduce el nombre de un archivo que quieras buscar : $r"
		read archivo
		echo -e "$azul Introduce la ruta en la que quieres buscar ese arhchivo: $r" 
		read ruta

		if ls $ruta | egrep -ow $archivo
		then
			echo -e "$amarillo Sí existe el archivo en la ruta especificada $r"
		else
			echo -e "$rojo No hay ningun archivo con ese nombre , no existe $r"
		fi
     ;;
	"hora" )
	echo -n -e "$rojo La hora actual es: $r";
	cat /proc/driver/rtc | egrep -o -m 1 [0-9]{2}+":"+[0-9]{2}+":"+[0-9]{2}	
	;;

	"fecha")
	echo -n -e "$azul La fecha actual es: $r"
	cat /proc/driver/rtc | egrep -o -m 1 [0-9]{4}+"-"+[0-9]{2}+"-"+[0-9]{2}

	;;

	"ayuda" )
	echo -e " --ESTE ES EL  MENÚ DE AYUDA CONSULTALO CADA VEZ QUE NECESITES AMIGO--$r"
	echo -e "\t$verde El comando (ayuda) te trae a este archivo :v $r"
	echo -e "\t$azul El comando  (busca) te ayuda a encontrar un archivo en el sistema debes pasarle 2 parametros el nombre del archivo y la ruta  $r"
	echo -e "\t$verde El comando (hora) te muestra la hora actual del sistema  $r"
	echo -e "\t$azul El comando (fecha )  te muestra la fecha actual C: $r"
 	echo -e "\t$verde El comando (infosys) te da la informacion basica del equipo  $r"
	echo -e "\t$azul El comando (arbol) te muestra un arbol de la ruta que le das  $r"
	echo -e "\t$verde El comando (creditos)  te muestra la informacion de los creadores  $r"
	echo -e "\t$azul El comando (gato) te dirige al juego del gato muy divertido :3 $r"
	echo -e "\t$verde El comando (pong) te lleva al juego del pong xD  $r"
	echo -e "\t$azul El comando (prebeplayer) te dirige a la prebeplayer donde podras reproducir musica :3 $r"
	echo -e "\t$verde El comando (salir) te saca de aqui alv de la Prebeshell    $r"

	;;

	"creditos")
		echo -e "\n\t\tLa Prebeshell "
		echo -e "${rojo}Hecho por:"
		echo -e "\t${azul}Jose Alejandro Montecillo Sandoval \n\tGerardo Alonso Pastor Olivera\n"
	;;
	"arbol")
 		declare -i DIM=0;
 	arbolito(){
 	    cd "$1";
 	    for archivo in *
 	    do
 		printf "\e[1;35m>";
 		printf  "\e[0m";
 		for ((i=0; $i < DIM; i++))
 		do
 		    printf "\e[32m-";
 		    printf "\e[0m";
 		done
 		if [ -d "$archivo" ]; then
 		    printf "\e[1;36m";
 		else
 		    printf "\e[1;33m";
		fi
 		printf "$archivo\e[0m\n";
 		if [ -d "$archivo" ]
 		then
 		    DIM=$DIM+1;
 		    arbolito "$archivo";
 		    cd ..;
 		fi
 	    done
 	 }
esac
