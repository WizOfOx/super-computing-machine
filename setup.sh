#!/bin/bash

echo "Decrypting license file..."
gpg --quiet --batch --yes --decrypt --passphrase=$THE_SECRET --output $HOME/license.lic $HOME/license.lic.gpg