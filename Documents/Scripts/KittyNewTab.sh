#!/bin/sh
exit=$(ls /tmp | grep '^kitty')

if [ $exit ]; then
  sock="unix:/tmp/$exit"
  /usr/local/bin/kitty @ --to $sock launch --type=tab --cwd $1 --no-response && open -a kitty
else
  open -a kitty --args $1
fi