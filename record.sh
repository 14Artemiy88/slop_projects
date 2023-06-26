#!/bin/bash

declare -r SCREENRECORD_PATH="/tmp/screenrecord.gif"

start_rec() {
	slop=$(slop -f "%x %y %w %h %g %i") || exit 1
	read -r X Y W H _ _ <<< "$slop"
	yes | ffmpeg -f x11grab -show_region 1  -s "$W"x"$H" -i :0.0+$X,$Y -f alsa -i pulse $SCREENRECORD_PATH
}

stop_rec() {
	killall ffmpeg
	xclip -selection clipboard -t image/gif -i $SCREENRECORD_PATH
	kdialog --yesno 'Save?'
  if [ $? = 0 ]; then
	  path=$(kdialog --getsavefilename "$HOME"/Images/"$(date +%s)".gif)
	  mv $SCREENRECORD_PATH "$path"
  fi
}

if [ "$(pidof ffmpeg)" ]; then
	stop_rec
else
	start_rec
fi
