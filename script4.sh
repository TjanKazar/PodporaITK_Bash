#!/bin/bash

calculate_size() {
    if [ "$include_hidden" = true ]; then
        size=$(du -sh .)
    else
        size=$(du -sh --exclude='*/.*' .)
    fi
    echo "Total size of the current directory is: $size"
}

echo "Do you want to include hidden files? (y/n)"
read user_input

if [[ "$user_input" == "y" || "$user_input" == "Y" ]]; then
    include_hidden=true
else
    include_hidden=false
fi

calculate_size
