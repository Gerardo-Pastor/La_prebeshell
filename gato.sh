#!/bin/bash

trap "" 2 20
trap "" SIGTSTP
salir=0
array=( "" "" "" "" "" "" "" "" "" "")

tablero () {
   clear
   echo -e "\t-------------------------"
   echo -e "\t|\t${array[7]:-7} | ${array[8]:-8} | ${array[9]:-9}\t|"
   echo -e "\t|\t_________\t|"
   echo -e "\t|\t${array[4]:-4} | ${array[5]:-5} | ${array[6]:-6}\t|"
   echo -e "\t|\t_________\t|"
   echo -e "\t|\t${array[1]:-1} | ${array[2]:-2} | ${array[3]:-3}\t|"
   echo -e "\t-------------------------\n"
  }

condiciones () {
	if [ $v == "${array[7]}" ] && [ $v == "${array[8]}" ] && [ $v == "${array[9]}" ]; then
		ganador
	elif [ $v == "${array[4]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[6]}" ]; then
		ganador
	elif [ $v == "${array[1]}" ] && [ $v == "${array[2]}" ] && [ $v == "${array[3]}" ]; then
		ganador
	elif [ $v == "${array[7]}" ] && [ $v == "${array[4]}" ] && [ $v == "${array[1]}" ]; then
		ganador
	elif [ $v == "${array[8]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[2]}" ]; then
		ganador
	elif [ $v == "${array[9]}" ] && [ $v == "${array[6]}" ] && [ $v == "${array[3]}" ]; then
		ganador
	elif [ $v == "${array[7]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[3]}" ]; then
		ganador
	elif [ $v == "${array[1]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[9]}" ]; then
		ganador
	fi
}


ganador () {
	clear
  echo -e "\n$USER_NO\n"
	 echo -e "\t\t\e[1;34m "  '   ____    _    _   _    _    ____   ___  ____  ' "   \e[0m  "
  echo -e "\t\t\e[1;34m "   '  / ___|  / \  | \ | |  / \  |  _ \ / _ \|  _ \  ' "   \e[0m  "
   echo -e "\t\t\e[1;34m "   '| |  _  / _ \ |  \| | / _ \ | | | | | | | |_) | ' "   \e[0m  "
   echo -e "\t\t\e[1;34m "   '| |_| |/ ___ \| |\  |/ ___ \| |_| | |_| |  _ < ' "   \e[0m  "
    echo -e "\t\t\e[1;34m "   '\____/_/   \_\_| \_/_/   \_\____/ \___/|_| \_\ ' "   \e[0m  "

  sleep 2
  clear
  
  exit 0
}

tie () {                                        
  for k in `seq 0 $( expr ${#array[@]} - 1) `
    do
     if [ ! -z ${array[$k]} ] ; then
      tic_array[$k]=$k
       if [ "9"  -eq ${#tic_array[@]} ] ; then
         clear
        sleep 2
        
        exit 0
       fi
     fi
   done
}

jugadores () {
	clear
	read -p "Ingresa tu nombre de jugador (player1): " player1
	echo -e "\n$player1 tu eres X \n"

	read -p "Ingresa tu nombre de jugador (player2): " player2
	echo -e "\n$player2 tu eres O"
}

EMPTY_CELL () {
   echo -e -n "${DEFAULT_COL}"
   read -e -p "$MSG" col
   case "$col" in
    [0-9]) if [  -z ${array[$col]}   ]; then
    CELL_IS=empty
   else
    CELL_IS=notempty
   fi;;
     *)  DEFAULT_COL=$COLOR_RED
     MSG="$USER_NO CONCENTRATE !!! Vas a perder si no escoges bien un numero prro  : "
     EMPTY_CELL;;
   esac
   echo -e -n "${COLOR_BLACK}"
  }


  CHOISE () {
   EMPTY_CELL
   if [ "$CELL_IS" == "empty" ]; then
    array[$col]="$v"
   else
    MSG="La caja no puede estar vacía, Re-Enter $USER_NO : "
    CHOISE
   fi
  }

  #Funcion Principal 
  echo "hola 7u7 si ves esto eres chido."
  while [ "$salir" == 0 ]; do
  case "$opc" in
    0) #Bienvenida al usuario.
     echo -e "\t\t\e[1;31m \n\n\n\t\t\t\tB I E N V E N I D O S  AL JUEGO \n"
     echo -e "\t\t\e[1;34m "  ' _____ _        ____    _  _____ ___    ' "   \e[0m  "
     echo -e "\t\t\e[1;34m "  ' | ____| |      / ___|  / \|_   _/ _ \  ' "   \e[0m  "
     echo -e "\t\t\e[1;34m "  ' |  _| | |     | |  _  / _ \ | || | | | ' "   \e[0m  "
     echo -e "\t\t\e[1;34m "  ' | |___| |___  | |_| |/ ___ \| || |_| | ' "   \e[0m  "
     echo -e "\t\t\e[1;34m "  ' |_____|_____|  \____/_/   \_\_| \___/  ' "   \e[0m  "

    echo -e  "\n\n\t\t\t  Selecciona una opción \e[1;37m\n\n\t\t\t      1) Comenzar juego\n\n\t\t\t      2) Instrucciones\n\t\t\t           3) Salir\n\t\t\t\e[0m"
    read opc
      ;;
    1) #Empieza un juevo nuevo
    opc=0
    read -n 1 -p "¿Listos para iniciar ?(s/n)" s
    if [ "$s" == "s" ] || [ "$s" == "S" ]; then
    clear
    jugadores
    sleep 2
  else
    clear
    exit 0
  fi
    tablero
    ((i++))
    while :
    do
    ((i++))
    jug=`expr $i % 2`
    if  [ "$jug" == "0" ]; then
     USER_NO=$player1
     MSG="$USER_NO Introduce tu elección : "
     v="X"
     CHOISE
    else
     USER_NO=$player2
     MSG="$USER_NO Introduce tu elección : "
     v="O"
     CHOISE
   fi
    tablero
    condiciones
    tie
  done
  echo -e "\e[1;31m\n\n\n\t      Presiona 'cualquier tecla ' para volver al menú principal."
  read
      ;;
    2) ##Aqui se muestran las instrucciones.
      opc=0
      clear
      echo -e "\e[1;34m\n\n\t\t\t Este es el juego tradicional del gato es para dos personas obvio 7u7 \n\n"
      echo -e "Los controles para jugar son los siguientes:"
      echo -e "\n7 8 9      _|_|_\n4 5 6  →    | | \n1 2 3      ‾|‾|‾\n\n"
      echo -e "Debes poder juntar tres simbolos iguales en la direccion horizontal o vertical o diagonal ya te la sabes :v "
      echo -e "\e[1;31m\n\t\tPresiona 'cualquier tecla ' para volver al menú principal."
      read
      ;;
    3) #Salir del juego
      opc=0
      salir=1
      ;;
    *)
      opc=0
      ;;
  esac
done