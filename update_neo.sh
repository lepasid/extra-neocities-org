#!/bin/bash

echo "# Optional Package - Neocities
# Repository: https://github.com/MeFinity/Neocities-Host
$NEOCITIES_IP neocities.org
$NEOCITIES_IP www.neocities.org
$NEOCITIES_IP blog.neocities.org" > hosts

NEOCITIES_IP="198.51.233.100"
USER_AGENT="Neocities Unblocker by KINI/1.3"
concurrent_requests=20

for ((current_page = 1; ; current_page++)); do
    output=$(curl -s -H "Connection: keep-alive" -A "$USER_AGENT" "https://neocities.org/browse?sort_by=last_updated&tag=&page=$current_page" | grep -Eo "https://[a-zA-Z0-9.-]+\.neocities\.org" | grep -vE "www\.neocities\.org|blog\.neocities\.org")

    if [ -z "$output" ]; then
        break
    fi

    echo -ne "..................($current_page)\r"

    echo "$output" | sed "s|^https://|$NEOCITIES_IP |" | sort -u >> hosts &

    if ((current_page % concurrent_requests == 0)); then
        wait
    fi
done
wait

echo "Done fetching pages."
