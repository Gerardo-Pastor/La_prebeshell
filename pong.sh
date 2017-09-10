#!/bin/bash
up=$'\x1b[A'
down=$'\x1b[B'

n=${1-24}
m=${2-80}
setterm -cursor off
stty -echo

echo "$n x $m"
declare -A canvas
vaciar (){
	for (( i=0 ; i<n ; i++ )); do for (( j=0 ; j<m ; j++ )); do
		canvas[$j,$i]=" "
	done done
}
draw (){
	clear
	echo "y: $y"
	for (( i=0 ; i<n ; i++ )); do for (( j=0 ; j<m ; j++ )); do
		printf "${canvas[$j,$i]}"
		done
		printf "\n"
	done
	vaciar
}
barra (){
	for(( i=$(($y-2)) ; i<$(($y+2)) ; i++ )); do
		canvas["1","$i"]="█"
	done
}


y=$(($n/2))
dirx="-1"
diry="0"

while [ 1 ]; do
	read -s -t 0.001 key
	case "$key" in
		$up)
			echo "Presed up"
			let "y--";;
		$down)
			let "y++";;
		"q") exit 1
	esac
	if [ "$y" -lt 2 ]; then
		y="2"
	fi
	if [ "$y" -eq $(($n-1)) ]; then
		y=$(($n-2))
	fi
	pelota
	barra
	draw
	key=" "

done
