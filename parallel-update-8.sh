#!/bin/bash

NEOCITIES_IP="198.51.233.100"
USER_AGENT="Neocities Unblocker [8] by KINI/1.5"
concurrent_requests=5
max_page=2000
min_page=1750

for ((current_page = 1750; current_page < max_page; current_page++)); do
    output=$(curl -s -H "Connection: keep-alive" -A "$USER_AGENT" "https://neocities.org/browse?sort_by=last_updated&tag=&page=$current_page" | grep -Eo "https://[a-zA-Z0-9.-]+\.neocities\.org" | grep -vE "www\.neocities\.org|blog\.neocities\.org")

    if [ -z "$output" ]; then
        break
    fi

    echo -ne "[8].................($current_page)\r"

    echo "$output" | sed "s|^https://|$NEOCITIES_IP |" | sort -u >> temphosts8 &

    if ((current_page % concurrent_requests == 0)); then
        wait
    fi
done
wait

echo "[8]Done fetching pages from $min_page to $max_page."