#!/bin/env bash

declare -r IMAGE_FILE="/run/user/1000/text.png"
declare -r TEXT="/tmp/translation"

lang=$(kdialog --radiolist "Select languages:" rus "RU" off eng "EN" off translate "Translate" on)
if [[ -z $lang ]]; then
	exit 1
fi

translate=0
if [ $lang = translate ]; then 
	lang="eng"
	translate=1
fi

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< "$slop"
import -window root -crop "$GEOMETRY" $IMAGE_FILE
tesseract $IMAGE_FILE $TEXT -l "$lang" 2>/dev/null
if [[ translate -eq 1 ]]; then
	source $HOME/.venvs/MyEnv/bin/activate
	python3 "$HOME"/Apps/slop_projects/translate.py "$(<$TEXT.txt)" > "$TEXT.txt"
fi

cat "$TEXT.txt" | xclip -selection c
kdialog --textbox "$TEXT.txt" --title "$lang"
