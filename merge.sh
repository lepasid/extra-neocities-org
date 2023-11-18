#!/bin/bash

output_file="hosts"
temp_folder="/temp"

for temp_file in "$temp_folder"/temphosts{1..6}; do
    if [ -e "$temp_file" ]; then
        cat "$temp_file" >> "$output_file"
    else
        echo "Warning: File $temp_file does not exist."
    fi
done

sort -u -o "$output_file" "$output_file"

echo "Merged hosts files successfully."

rm -f "$temp_folder"/temphosts{1..6}
rmdir "$temp_folder"
