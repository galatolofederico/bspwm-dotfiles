#!/bin/sh

POLYBAR_CMD="polybar -r -config ~/.config/polybar/config.ini top"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m $POLYBAR_CMD &
  done
else
  $POLYBAR_CMD &
fi