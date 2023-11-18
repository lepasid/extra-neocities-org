#!/bin/bash

NEOCITIES_IP="198.51.233.100"
USER_AGENT="Neocities Unblocker [4] by KINI/1.4"
concurrent_requests=5
max_page=2000
min_page=1501

for ((current_page = 1501; current_page < max_page; current_page++)); do
    output=$(curl -s -H "Connection: keep-alive" -A "$USER_AGENT" "https://neocities.org/browse?sort_by=last_updated&tag=&page=$current_page" | grep -Eo "https://[a-zA-Z0-9.-]+\.neocities\.org" | grep -vE "www\.neocities\.org|blog\.neocities\.org")

    if [ -z "$output" ]; then
        break
    fi

    echo -ne "[4].................($current_page)\r"

    echo "$output" | sed "s|^https://|$NEOCITIES_IP |" | sort -u >> /temp/temphosts4 &

    if ((current_page % concurrent_requests == 0)); then
        wait
    fi
done
wait

echo "[4]Done fetching pages from $min_page to $max_page."