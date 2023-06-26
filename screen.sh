#!/bin/bash

declare -r SCREENSHOT_PATH="/tmp/screenshot.png"

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< $slop
import -window root -crop $GEOMETRY $SCREENSHOT_PATH
xclip -selection clipboard -t image/png -i $SCREENSHOT_PATH
