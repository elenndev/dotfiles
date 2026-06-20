#!/bin/bash
source .env

ENCRYPT=$(crip-crypt encrypt "$FOLDER_TO_ENCRYPT_DIR" "$ENCRYPT_ZIP_OUTPUT" --password "$PASSWORD")
echo "$ENCRYPT"

ENCRYPTED_ZIP_FILE=$(echo "$ENCRYPT" | grep "^Output:" | sed 's/^Output: "//' | sed 's/"$//')
