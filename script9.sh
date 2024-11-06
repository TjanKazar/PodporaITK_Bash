#!/bin/bash

convert_path() {
    path="$1"
    path="${path//\\//}" 
    path="${path//C:/\/c}" 
    echo "$path"
}

create_archive() {
    dir="$1"
    
    if [ ! -d "$dir" ]; then
        echo "Napaka: Podimenik '$dir' ne obstaja."
        return
    fi

    timestamp=$(date +"%Y%m%d_%H%M%S")
    archive_name="${dir}_backup_$timestamp.tar.gz"

    latest_backup=$(ls ${dir}_backup_*.tar.gz 2>/dev/null | sort -r | head -n 1)

    if [ -n "$latest_backup" ]; then
        backup_time=$(stat --format=%Y "$latest_backup")
        current_time=$(date +%s)
        time_diff=$(( (current_time - backup_time) / 60 / 60 / 24 ))

        echo "Najnovejši arhiv: $latest_backup"
        echo "Čas zadnje varnostne kopije: $backup_time"
        echo "Trenutni čas: $current_time"
        echo "Razlika v dneh: $time_diff"

        if [ "$time_diff" -lt 7 ]; then
            echo "Opozorilo: Arhiv za podimenik '$dir' že obstaja in je bil narejen pred manj kot 7 dnevi ($time_diff dni)."
            return
        fi
    else
        echo "Ni najdenih prejšnjih arhivov za podimenik '$dir'."
    fi

    tar -czf "$archive_name" -C "$(dirname "$dir")" "$(basename "$dir")"
    echo "Arhiv za podimenik '$dir' je bil ustvarjen kot '$archive_name'."
}

if [ -z "$1" ]; then
    echo "Napaka: Prosimo, podajte pot do imenika."
    exit 1
fi

parent_dir=$(convert_path "$1")

if [ ! -d "$parent_dir" ]; then
    echo "Napaka: '$parent_dir' ni veljaven imenik."
    exit 1
fi

parent_dir="$parent_dir"

for subdir in "$parent_dir"/*/
do
    create_archive "$subdir"
done
