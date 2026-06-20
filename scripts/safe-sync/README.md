# Dependencies
```bash
apt install curl jq
```

# Usage
```bash
chmod +x backup.sh
```

Authenticate to get yout google refresh token and save it in the .env file, only need to do this once.
```bash
./backup.sh auth
```

Run the backup, set the file directory and encryption password in the .env file
```bash
./backup.sh save
```

