#!/bin/bash

sleep 3;

display_x=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
display_y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

while true; do
    glava "--request=setgeometry 0 0 $display_x $display_y" "--request=setopacity xroot" -d;
    notify-send "Glava crashed waiting 5 seconds";
    sleep 5;
done
    
