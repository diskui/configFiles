#!/bin/zsh

# picom -b --experimental-backends &
picom -b &

xsetroot -cursor_name left_ptr &


~/scripts/touchpad_shutdown.sh &


fcitx5 -d &


~/.config/bspwm/autoChangeWP.sh &

