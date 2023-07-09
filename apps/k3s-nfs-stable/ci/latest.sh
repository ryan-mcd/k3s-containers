#!/usr/bin/env bash
version="$(curl -s https://update.k3s.io/v1-release/channels | jq '.data[] | select(.id=="stable")' | jq -r .latest 2>/dev/null | sed "s/+/-/g")"
printf "%s" "${version}"