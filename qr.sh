#!/bin/bash

declare -r SCREENSHOT_PATH="/run/user/1000/qr.png"
source $HOME/.venvs/MyEnv/bin/activate

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< $slop
import -window root -crop $GEOMETRY $SCREENSHOT_PATH
text=$(python3 "$HOME"/Apps/slop_projects/qr.py)
kdialog --passivepopup "$text" 2
echo $text | xclip -selection clipboard
