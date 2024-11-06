#Napišite skripto, ki kot vhod prejme seznam celih števil in za vsako število določi, ali je sodo ali liho. Na koncu naj skripta izpiše povzetek, koliko sodih in koliko lihih števil je bilo vnešenih. 
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Prosim, podajte seznam celih števil kot argumente."
    exit 1
fi

even_count=0
odd_count=0

for num in "$@"
do
    if ! [[ "$num" =~ ^-?[0-9]+$ ]]; then
        echo "Napaka: '$num' ni celo število."
        continue
    fi
    
    if (( num % 2 == 0 )); then
        even_count=$((even_count + 1))
    else
        odd_count=$((odd_count + 1))
    fi
done

echo "Povzetek:"
echo "Število sodih števil: $even_count"
echo "Število lihih števil: $odd_count"
