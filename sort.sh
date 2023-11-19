#!/bin/bash
sort_file="hosts-sort"
output_file="hosts"
NEOCITIES_IP="198.51.233.100"

echo "# [Paket Extra - neocities.org]
# Repository: https://github.com/lepasid/extra-neocities-org
$NEOCITIES_IP neocities.org
$NEOCITIES_IP www.neocities.org
$NEOCITIES_IP blog.neocities.org" > "$output_file"

cat "$sort_file" >> "$output_file"

echo "Header added succesfully"