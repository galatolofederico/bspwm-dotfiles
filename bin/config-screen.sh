#!/bin/sh
. $HOME/.env.sh

if [[ $(xrandr -q | grep "$SECONDARY_MONITOR connected") ]]; then
    $HOME/bin/screen multi
else
    $HOME/bin/screen single
fi

