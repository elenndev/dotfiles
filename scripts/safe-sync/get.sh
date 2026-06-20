#!/bin/bash
source .env
source ./auth.sh

RESPONSE=$(
  curl -s --get \
    -H "Authorization: Bearer $TOKEN" \
    --data-urlencode "q='$FOLDER_ID' in parents and trashed=false" \
    --data-urlencode "orderBy=createdTime desc" \
    --data-urlencode "pageSize=1" \
    --data-urlencode "fields=files(id,name,createdTime)" \
    "https://www.googleapis.com/drive/v3/files"
)

MOST_RECENT_FILE_ID=$(jq -r '.files[0].id' <<<"$RESPONSE")
MOST_RECENT_FILE_NAME=$(jq -r '.files[0].name' <<<"$RESPONSE")

echo "File Id: $MOST_RECENT_FILE_ID
File Name: $MOST_RECENT_FILE_NAME"

echo "Downloading..."

DOWNLOAD_DIR=/home/elen/Downloads

if [ ! -d "$DOWNLOAD_DIR" ]; then
  echo Error: Dir. "$DOWNLOAD_DIR" does not exist
  exit 1
fi

curl -L \
  -H "Authorization: Bearer $TOKEN" \
  "https://www.googleapis.com/drive/v3/files/$FILE_ID?alt=media" \
  -o "$DOWNLOAD_DIR/$MOST_RECENT_FILE_NAME"

CHECK_DOWNLOAD="$DOWNLOAD_DIR/$MOST_RECENT_FILE_NAME"

echo "$CHECK_DOWNLOAD"

if [ ! -f "$CHECK_DOWNLOAD" ]; then
  echo Error trying to download file
  exit 1
fi

echo Check file "$MOST_RECENT_FILE_NAME" on "$DOWNLOAD_DIR"

"$@"
