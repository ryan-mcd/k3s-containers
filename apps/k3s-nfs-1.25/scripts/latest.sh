#!/usr/bin/env bash
version="$(curl -s https://update.k3s.io/v1-release/channels | jq '.data[] | select(.id=="v1.25")' | jq -r .latest 2>/dev/null)"
printf "%s" "${version}"