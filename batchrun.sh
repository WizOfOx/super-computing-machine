#!/bin/bash

# Make sure one argument is passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <key> <command>"
    exit 1
fi

KEY=$1
CMD=$2

echo "Decrypting license file..."
gpg --quiet --batch --yes --decrypt --passphrase=$KEY --output /home/matlab/license.lic /home/matlab/license.lic.gpg

echo "Running command..."
/bin/run.sh -batch "$CMD"