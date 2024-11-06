#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 filename1 filename2 ..."
    exit 1
fi

for filename in "$@"; do
    matches=($(ls "$filename".* 2>/dev/null))

    if [ ${#matches[@]} -eq 0 ]; then
        echo "Datoteka z tem imenom ni najdena: '$filename'."
    else
        for file in "${matches[@]}"; do
            extension="${file##*.}"
            echo "Datoteka '$file' ima končnico: .$extension"
        done
    fi
done
