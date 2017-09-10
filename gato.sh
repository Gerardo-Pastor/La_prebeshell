#!/bin/bash

trap "" 2 20
trap "" SIGTSTP

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
		ganaste
	elif [ $v == "${array[4]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[6]}" ]; then
		ganaste
	elif [ $v == "${array[1]}" ] && [ $v == "${array[2]}" ] && [ $v == "${array[3]}" ]; then
		ganaste
	elif [ $v == "${array[7]}" ] && [ $v == "${array[4]}" ] && [ $v == "${array[1]}" ]; then
		ganaste
	elif [ $v == "${array[8]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[2]}" ]; then
		ganaste
	elif [ $v == "${array[9]}" ] && [ $v == "${array[6]}" ] && [ $v == "${array[3]}" ]; then
		ganaste
	elif [ $v == "${array[7]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[3]}" ]; then
		ganaste
	elif [ $v == "${array[1]}" ] && [ $v == "${array[5]}" ] && [ $v == "${array[9]}" ]; then
		ganaste
	fi
}


ganaste () {
	clear
  echo -e "\n$USER_NO\n"
	echo "ganaste"
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
	read -p "jugador 1 escoge tu nombre: " jugador1
	echo -e "\n$jugador1 tu eres X \n"

	read -p "jugador 2 escoge tu nombre: " jugador2
	echo -e "\n$jugador2 tu eres O"
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
     MSG="$USER_NO Vamos! escoge bien un numero numero : "
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

  #main
  clear
 
  echo -e "\nEL gato es para dos personas\n"
  echo -e "Los controles para jugar son los siguientes:"
  echo -e "\n7 8 9      _|_|_\n4 5 6  →    | | \n1 2 3      ‾|‾|‾\n\n"

  read -n 1 -p "¿Deseas continuar?(s/n)" s

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
     USER_NO=$jugador1
     MSG="$USER_NO Introduce tu elección : "
     v="X"
     CHOISE
    else
     USER_NO=$jugador2
     MSG="$USER_NO Introduce tu elección : "
     v="O"
     CHOISE
   fi

    tablero
    condiciones
    tie
  done
  
exit 0