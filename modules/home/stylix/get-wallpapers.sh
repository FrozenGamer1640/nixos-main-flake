#!/usr/bin/env bash

declare -A wallpapers=( ["wallpapers/LennGGO-01.jpg"]="https://i.pinimg.com/736x/7b/a9/cb/7ba9cb03c024bf59e59ac59e759c5a54.jpg" )

for key in "${!wallpapers[@]}"; do
    if [ -f "$key" ]; then
        echo "File $key already exists. Skipping download."
        continue
    fi
    curl -o $key ${wallpapers[$key]}
done