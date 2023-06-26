#!/bin/env bash

declare -r IMAGE_FILE="/tmp/text.png"
declare -r TEXT="/tmp/translation"

lang=$(kdialog --radiolist "Select languages:" rus "RU" off eng "EN" on)
if [[ -z $lang ]]; then
	exit 1
fi

slop=$(slop -f "%g") || exit 1
read -r GEOMETRY <<< "$slop"
import -window root -crop "$GEOMETRY" $IMAGE_FILE
tesseract $IMAGE_FILE $TEXT -l "$lang" 2>/dev/null
cat "$TEXT.txt" | xclip -selection c
#kdialog --msgbox "$(cat $TEXT.txt)" --title "$lang"
kdialog --textbox "$TEXT.txt" --title "$lang"
