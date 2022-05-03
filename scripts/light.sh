#!/bin/zsh

xbacklight -set $1

brightnessctl -c backlight s $1%

