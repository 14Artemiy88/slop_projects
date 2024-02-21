#!/bin/bash

declare -r SCREENSHOT_PATH="/run/user/1000/qr.png"

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< $slop
import -window root -crop $GEOMETRY $SCREENSHOT_PATH
python3 "$HOME"/Apps/slop_projects/qr.py | xclip -selection clipboard
