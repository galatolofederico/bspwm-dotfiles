#!/bin/bash

sleep 3;

display_x=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
display_y=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

glava "--request=setgeometry 0 0 $display_x $display_y" "--request=setopacity xroot" -d