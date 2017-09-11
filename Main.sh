#!/bin/bash

trap "" 2 20
trap "" SIGTSTP  #anula Ctrl + C   y  Ctrl + Z
clear

fails=3
while [ $fails != 0 ]; do         #salir o equivocarse 3 vece
    base=$PWD
    echo -e -n "\033[32m User: \033[00m" 
    read usar  
    echo -e -n "\033[32m Password: \033[00m"
    read -s pswd        # -s oculta el input del usuario
    if [ "$usar" == "salir" ]; then 
        exit 1 
    fi

    linea=`sudo -S grep -r $usar /etc/shadow`

    if [ ${linea} > 1 ]; then 

        IFS='$' read -r -a array <<< "$linea"  

        index="\$${array[1]}\$${array[2]}"
        hash=`python -c 'import crypt; import sys; print crypt.crypt( sys.argv[1] , sys.argv[2])' $pswd $index`

        match=`echo "$linea" | grep -c "$hash"`             #detecta si se dieron like en tinder

        if [ "$match" -eq 1 ]; then
            clear
            echo -e "\033[34m            Hola Amiguito"
            
            while [ 1 ];do                                  #Comandos a ingresar
                printf "\033[01;34mPrebeShell@$usar: $PWD \033[01;33m" 
                read  command
                cd $base
                case "$command" in
                    "ayuda")        ./commands.sh ayuda          ;;
                    "infosis")      ./commands.sh infosys        ;;
                    "arbol")        ./commands.sh arbol $base    ;;
                    "fecha")        ./commands.sh fecha          ;;
                    "hora")         ./commands.sh hora           ;;
                    "busca")        ./commands.sh busca          ;;
                    "pong")         ./pong.sh                    ;;
                    "gato")         ./gato.sh                    ;;
                    "creditos")     ./commands.sh creditos       ;;
                    "prebeplayer")  ./PrebePlayer.sh $current    ;;
                    "salir")        exit 1                       ;;
                    *)              cd $current 
                                    $command; current=$PWD       ;;
                esac
                cd $current
            done
        else
            echo -e "\n\033[31m Contrasena incorrecta te quedan $(($fails-1)) intentos \033[00m"
            let fails--
        fi
    else
        echo -e "\033[31m Oshe no encuentro ese usuario \033[00m"
        let fails--
    fi
done
echo -e "\n\033[01;33m\n Adios perro \n"