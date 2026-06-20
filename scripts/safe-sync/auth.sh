#!/bin/bash
set -e

source .env

TOKEN=$(
  curl -s \
    -X POST https://oauth2.googleapis.com/token \
    -d client_id="$CLIENT_ID" \
    -d client_secret="$CLIENT_SECRET" \
    -d refresh_token="$REFRESH_TOKEN" \
    -d grant_type=refresh_token |
    jq -r '.access_token'
)

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "Failed to obtain access token"
  exit 1
fi
