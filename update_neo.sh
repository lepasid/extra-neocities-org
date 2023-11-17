#!/bin/bash

current_page=0

while :; do
    current_page=$((current_page + 1))
    echo -ne "Fetching pages... ($current_page)\r"

    output=$(curl -s -H "Connection: keep-alive" -A "Neocities Unblocker by KINI/1.0" "https://neocities.org/browse?page=$current_page" | grep -Eo "https://[a-zA-Z0-9.-]+\.neocities\.org" | grep -v "www\.neocities\.org" | grep -v "blog\.neocities\.org")

    if [ -z "$output" ]; then
        break
    fi

    echo "# Optional Package - Neocities
# Repository: https://github.com/MeFinity/Neocities-Host
198.51.233.100 neocities.org
198.51.233.100 www.neocities.org
198.51.233.100 blog.neocities.org" >> hosts
    echo "$output" | sed "s|^https://|198.51.233.100 |" | sort -u >> hosts
done

echo "Done fetching pages."
