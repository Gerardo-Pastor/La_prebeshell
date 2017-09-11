#!/bin/bash
cd $1
clear 
while [ "$OPC" != "3" ]; do
Install=$(dpkg --get-selections | grep -w mpg123 | grep -w install)
  if [ "$Install" = "" ]; then
      echo -e "\n e We no tienes mpg123. Quieres instalarlo? 1) Si  3) No \n\n"
      read OPC
      case $OPC in 
      	1) 	sudo apt-get install mpg123
				echo -e "\n mpg123 has sido instalado."
		;;
		3)	echo -e "¡Total ni te gusta la musica!"
		;;
      	esac
      
  else
	  echo -e "Carpeta: $PWD\n\033[01;31m"
	  ls --color
	  echo -e "\n\033[35mQue vamo a hacer? \n\033[01;36m "
	  echo -e "\t1)\033[35mReproducir el contenido de la carpeta actual\033[01;36m"
	  echo -e "\t2)\033[35mCambiar de carpeta\033[01;36m"
	  echo -e "\t3)\033[35mSalir\033[01;35m"
	  
	  read OPC
	  toca = pwd
	  clear
	  	  case $OPC in
		  1)  	`mpg123 -C -d $toca*` ;;
		  2) 	echo -e "Introduce la ruta a la que deseas ir: "  
		  		read r
		  		cd $r ;;
		  3)	echo -e "uy que aguado bye bye \n";;
		  *) 	echo -e "Kha!?"
				read -p "Enter to continue..." prebe;;
	  esac
	  clear
  fi
done