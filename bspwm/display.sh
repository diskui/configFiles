
#! /bin/zsh

#display setting
if [[ $(xrandr -q | grep "eDP1 connected") ]] || [[ $(xrandr -q | grep "DP1 connected") ]]; then
    ~/.config/bspwm/dual_display &
fi
