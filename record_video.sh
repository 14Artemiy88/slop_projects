#!/bin/bash

declare -r MKV_PATH="/run/user/1000/screenrecord.mkv"

start_rec() {
	slop=$(slop -f "%x %y %w %h %g %i") || exit 1
	read -r X Y W H _ _ <<< "$slop"
	# (( FPS=$(kdialog --slider "Select a FPS" 1 60 5) ))
	ffmpeg -y -f x11grab -show_region 1 -s "$W"x"$H" -i :0.0+$X,$Y -f pulse -ac 2 -i 2 $MKV_PATH
}

stop_rec() {
	killall ffmpeg
	xclip -selection clipboard -t image/gif -i $MKV_PATH
	kdialog --yesno 'Save?'
  if [ $? = 0 ]; then
	  path=$(kdialog --getsavefilename "$HOME"/Images/"$(date +%s)".mkv)
	  mv $MKV_PATH "$path"
  fi
}

if [ "$(pidof ffmpeg)" ]; then
	stop_rec
else
	start_rec
fi
