#!/bin/env bash

declare -r TEXT="/run/user/1000/translation"
source $HOME/.venvs/MyEnv/bin/activate

str="$( xclip -o)"

python3 "$HOME/Apps/slop_projects/translate.py" "$str" > "$TEXT.txt"

# pwd > "$TEXT.txt"
# batcat "$TEXT.txt"
# cat "$TEXT.txt" | xclip -selection c
kdialog --textbox "$TEXT.txt" --title "$lang" --geometry=600x400+1800+300
