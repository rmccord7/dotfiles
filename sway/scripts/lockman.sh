#!/bin/sh

swayidle \
  timeout 10 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' &

#Locks screen immediately
swaylock -f -i /usr2/rmccord/Downloads/rootaccess2_M.png -c 000000

# Kills last background task so idle timer doesn't keep running.
kill %%
