function fastmount {
    devname=$(basename $1)
    sudo mkdir -p /mnt/$devname
    sudo mount /dev/$devname /mnt/$devname
}

function encrypt {
    openssl aes-256-cbc -a -salt -pbkdf2 -in "$1" -out "$1.enc"
}

function decrypt {
    encname=$1
    origname=${encname%.enc}
    openssl aes-256-cbc -d -a -pbkdf2 -in "$encname" -out "$origname"
}