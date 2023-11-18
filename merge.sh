#!/bin/bash

output_file="hosts"
NEOCITIES_IP="198.51.233.100"

echo "# Optional Package - Neocities
# Repository: https://github.com/MeFinity/Neocities-Host
$NEOCITIES_IP neocities.org
$NEOCITIES_IP www.neocities.org
$NEOCITIES_IP blog.neocities.org" > "$output_file"

for temp_file in temphosts{1..12}; do
    if [ -e "$temp_file" ]; then
        cat "$temp_file" >> "$output_file"
    else
        echo "Warning: File $temp_file does not exist."
    fi
done

sort -u -o "$output_file" "$output_file"

echo "Merged hosts files successfully."

rm -f temphosts{1..12}
