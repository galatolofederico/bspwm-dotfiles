function fastmount {
    devname=$(basename $1)
    sudo mkdir -p /mnt/$devname
    sudo mount /dev/$devname /mnt/$devname
}