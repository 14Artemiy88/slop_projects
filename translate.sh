#!/bin/env bash

declare -r TEXT="/tmp/translation"

str="$( xclip -o)"

python3 "$HOME"/Apps/slop_projects/translate.py "$str" > "$TEXT.txt"

# cat "$TEXT.txt" | xclip -selection c
kdialog --textbox "$TEXT.txt" --title "$lang" --geometry=600x400+1800+300
