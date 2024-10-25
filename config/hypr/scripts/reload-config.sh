#!/bin/bash

killall -e waybar
waybar &

hyprctl reload

killall -e hyprpaper
hyprpaper &
