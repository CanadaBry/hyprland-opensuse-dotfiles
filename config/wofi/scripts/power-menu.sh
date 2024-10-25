#!/bin/sh

op=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i --dmenu | awk '{print tolower($2)}')

case $op in 
  poweroff)
    ;&
  reboot)
    ;&
  suspend)
    exec systemctl $op;;
  lock)
    hyprlock;;
  logout)
    hyprctl dispatch exit;;
esac
