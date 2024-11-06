# Ustvarite skripto, ki prešteje število datotek v trenutnem imeniku, filtrira datoteke glede na njihovo končnico (npr. .txt datoteke) in izpiše to število.
#!/bin/bash

declare -A file_counts

for file in *; do
    if [ -f "$file" ]; then
        extension="${file##*.}"
        
        ((file_counts["$extension"]++))
    fi
done

echo "Število datotek, grupiranih po tipu datoteke:"
for extension in "${!file_counts[@]}"; do
    echo ".$extension: ${file_counts[$extension]} file(s)"
done
