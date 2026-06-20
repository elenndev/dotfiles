#!/bin/bash
set -e

source .env

AUTH_URL="https://accounts.google.com/o/oauth2/v2/auth\
?client_id=${CLIENT_ID}\
&redirect_uri=${REDIRECT_URI}\
&response_type=code\
&scope=https://www.googleapis.com/auth/drive.file\
&access_type=offline\
&prompt=consent"

echo
echo "Open this url on your browser:"
echo
echo "$AUTH_URL"
echo

read -p "paste here the authorization code: " CODE
