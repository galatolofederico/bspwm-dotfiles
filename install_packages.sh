#!/bin/sh

if [ -z ${AUR_HELPER+x} ]; then
    echo "Aur helper not specified, plese set the AUR_HELPER environment variable"
    exit
fi

"$AUR_HELPER" -S $(cat packages.txt | tr "\n" " ")