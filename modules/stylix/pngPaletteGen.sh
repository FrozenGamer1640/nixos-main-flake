#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <file.json> [out.png]"
    exit 1
fi

JSON_FILE="$1"
OUTPUT_FILE="${2:-out.png}"

TEMP_TILES_LIST=$(mktemp)

i=0

while IFS= read -r color; do
    TILE_NAME="temp_tile_$i.png"

    magick -size 1x1 xc:"#$color" "$TILE_NAME"

    echo "$TILE_NAME" >> "$TEMP_TILES_LIST"
    i=$((i + 1))
done < <(rg -o -N -r '$1' '"([\d\w]{6})",' "$JSON_FILE")

FILES_TO_MERGE=$(cat "$TEMP_TILES_LIST")

if [ -z "$FILES_TO_MERGE" ]; then
    echo "$FILES_TO_MERGE"
    echo "ERROR: Could not extract colors."
    rm "$TEMP_TILES_LIST"
    exit 1
fi

magick temp_tile_*.png +append "$OUTPUT_FILE"

rm temp_tile_*
rm "$TEMP_TILES_LIST"
