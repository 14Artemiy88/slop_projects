#!/bin/env bash

declare -r IMAGE_FILE="/tmp/text.png"
declare -r TEXT="/tmp/translation"

lang=$(kdialog --radiolist "Select languages:" rus "RU" off eng "EN" off translate "Translate" on)
if [[ -z $lang ]]; then
	exit 1
fi

translate=false
if [ $lang = translate ]; then 
	lang="eng"
	translate=true
fi

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< "$slop"
import -window root -crop "$GEOMETRY" $IMAGE_FILE
tesseract $IMAGE_FILE $TEXT -l "$lang" 2>/dev/null
if [ translate ]; then
	python3 "$HOME"/Apps/slop_projects/translate.py "$(<$TEXT.txt)" > "$TEXT.txt"
fi

cat "$TEXT.txt" | xclip -selection c
kdialog --textbox "$TEXT.txt" --title "$lang"
