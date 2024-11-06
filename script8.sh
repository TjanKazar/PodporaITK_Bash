# Napišite skripto, ki preveri dovoljenja za več datotek, ki jih prejme kot argumente, in izpiše za vsako datoteko, ali je berljiva, zapisljiva in/ali izvedljiva. Poleg tega naj skripta preveri, ali so dovoljenja ustrezna za trenutno uporabniško vlogo (lastnik, skupina, drugi).
#!/bin/bash

check_permissions() {
    file="$1"

    if [ ! -e "$file" ]; then
        echo "Error: File '$file' does not exist."
        return
    fi

    perms=$(ls -l "$file" | awk '{print $1}')

    owner_perms="${perms:1:3}"
    group_perms="${perms:4:3}"
    others_perms="${perms:7:3}"

    echo "Permissions for '$file':"

    if [[ $owner_perms == *r* ]]; then
        echo "  Owner: Readable"
    else
        echo "  Owner: Not Readable"
    fi
    if [[ $owner_perms == *w* ]]; then
        echo "  Owner: Writable"
    else
        echo "  Owner: Not Writable"
    fi
    if [[ $owner_perms == *x* ]]; then
        echo "  Owner: Executable"
    else
        echo "  Owner: Not Executable"
    fi

    if [[ $group_perms == *r* ]]; then
        echo "  Group: Readable"
    else
        echo "  Group: Not Readable"
    fi
    if [[ $group_perms == *w* ]]; then
        echo "  Group: Writable"
    else
        echo "  Group: Not Writable"
    fi
    if [[ $group_perms == *x* ]]; then
        echo "  Group: Executable"
    else
        echo "  Group: Not Executable"
    fi

    if [[ $others_perms == *r* ]]; then
        echo "  Others: Readable"
    else
        echo "  Others: Not Readable"
    fi
    if [[ $others_perms == *w* ]]; then
        echo "  Others: Writable"
    else
        echo "  Others: Not Writable"
    fi
    if [[ $others_perms == *x* ]]; then
        echo "  Others: Executable"
    else
        echo "  Others: Not Executable"
    fi

    echo "" 
}

if [ $# -eq 0 ]; then
    echo "Error: No files provided. Please specify one or more files."
    exit 1
fi

for file in "$@"
do
    check_permissions "$file"
done
