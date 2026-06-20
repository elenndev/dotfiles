#!/bin/bash
source .env
source ./auth.sh
source ./encrypt.sh

curl -s \
  -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -F "metadata={
      \"name\":\"$(basename "$ENCRYPTED_ZIP_FILE")\",
      \"parents\":[\"$FOLDER_ID\"]
    };type=application/json;charset=UTF-8" \
  -F "file=@$ENCRYPTED_ZIP_FILE" \
  "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"
