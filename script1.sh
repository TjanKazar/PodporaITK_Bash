# Napišite skripto, ki uporabnika vpraša za njegovo ime in starost. Če je starost uporabnika manjša od 18, naj skripta izpiše posebno sporočilo, drugače naj izpiše običajen pozdrav.


#!/bin/bash

echo "Please enter a number:"
read number

if [ "$number" -lt 17 ]; then
    echo "Permission denied. User not valid"
elif [ "$number" -ge 18 ]; then
    echo "Perimission granted. welcome !"
else
    echo "Invalid input."
fi