#!/bin/bash

# Make sure one argument is passed
if [ $# -ne 1 ]; then
    echo "Usage: $0 <key>"
    exit 1
fi

KEY=$1

echo "Decrypting license file..."
gpg --quiet --batch --yes --decrypt --passphrase=$KEY --output $HOME/license.lic $HOME/license.lic.gpg