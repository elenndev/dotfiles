#!/bin/bash
source .env

auth() {
  bash ./auth.sh
}

save() {
  bash ./encrypt.sh
  bash ./upload.sh
}

get() {
  bash ./get.sh
}

"$@"
