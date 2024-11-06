# Ustvarite skripto, ki kot vhod prejme več imen datotek in ustvari varnostno kopijo vsake datoteke s časovnim žigom. Skripta naj preveri, ali datoteke že obstajajo, ter opozori uporabnika, če je varnostna kopija že bila ustvarjena v zadnjih 24 urah.

#!/bin/bash

# Funkcija za ustvarjanje varnostne kopije
create_backup() {
    file="$1"
    
    # Preverimo, ali datoteka obstaja
    if [ ! -f "$file" ]; then
        echo "Napaka: Datoteka '$file' ne obstaja."
        return
    fi

    # Ustvarimo časovni žig
    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_file="${file}_backup_$timestamp"

    # Preverimo, če varnostna kopija obstaja v zadnjih 24 urah
    if [ -f "$file"_backup* ]; then
        # Preverimo datum zadnje varnostne kopije
        latest_backup=$(ls -t ${file}_backup* | head -n 1)
        backup_time=$(stat --format=%Y "$latest_backup")
        current_time=$(date +%s)
        time_diff=$(( (current_time - backup_time) / 60 / 60 ))

        if [ "$time_diff" -lt 24 ]; then
            echo "Opozorilo: Varnostna kopija za datoteko '$file' že obstaja in je bila narejena pred manj kot 24 urami ($time_diff ur)."
            return
        fi
    fi

    # Ustvarimo varnostno kopijo
    cp "$file" "$backup_file"
    echo "Varnostna kopija datoteke '$file' je bila ustvarjena kot '$backup_file'."
}

# Preverimo, ali so bili podani argumenti
if [ $# -eq 0 ]; then
    echo "Napaka: Prosimo, podajte imena datotek, ki jih želite varnostno kopirati."
    exit 1
fi

# Iteriramo skozi vse vhodne argumente (datoteke)
for file in "$@"
do
    create_backup "$file"
done
