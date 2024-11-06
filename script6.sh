# Ustvarite osnovno skripto za kalkulator, ki lahko izvaja seštevanje, odštevanje, množenje in deljenje več števil, ki jih prejme kot argumente, ter omogoči uporabniku, da izbere željeno operacijo. 


#!/bin/bash

addition() {
    result=0
    for num in "$@"; do
        result=$((result + num))
    done
    echo "Rezultat seštevanja: $result"
}

subtraction() {
    result=$1
    shift
    for num in "$@"; do
        result=$((result - num))
    done
    echo "Rezultat odštevanja: $result"
}

multiplication() {
    result=1
    for num in "$@"; do
        result=$((result * num))
    done
    echo "Rezultat množenja: $result"
}

division() {
    result=$1
    shift
    for num in "$@"; do
        if [ $num -eq 0 ]; then
            echo "Napaka: Deljenje z nič!"
            return 1
        fi
        result=$((result / num))
    done
    echo "Rezultat deljenja: $result"
}

if [ $# -lt 2 ]; then
    echo "Napaka: Potrebujete vsaj dve številki za izvedbo operacije."
    exit 1
fi

echo "Izberite operacijo:"
echo "1. Seštevanje"
echo "2. Odštevanje"
echo "3. Množenje"
echo "4. Deljenje"

read -p "Vnesite številko operacije (1/2/3/4): " operation

case $operation in
    1) addition "$@" ;;
    2) subtraction "$@" ;;
    3) multiplication "$@" ;;
    4) division "$@" ;;
    *)
        echo "Napaka: Neveljavna izbira operacije."
        exit 1
        ;;
esac
