#!/bin/sh

# show devices aplay -l / arecord -l

INPUT_DEVICE=2
OUTPUT_DEVICE=0

jackd -dalsa -r48000 -p256 -D -Chw:$INPUT_DEVICE -Phw:$OUTPUT_DEVICE &
sleep 5;
notify-send "Jack server started" -t 3000

pactl unload-module module-jack-sink
pactl unload-module module-jack-source

pactl load-module module-jack-sink
pactl load-module module-jack-source

pacmd set-default-sink jack_out
pacmd set-default-source jack_in
