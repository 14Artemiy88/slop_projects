#!/bin/bash

declare -r GIF_PATH="/run/user/1000/screenrecord.gif"

start_rec() {
	slop=$(slop -f "%x %y %w %h %g %i") || exit 1
	read -r X Y W H _ _ <<< "$slop"
	# (( FPS=$(kdialog --slider "Select a FPS" 1 60 5) ))
	ffmpeg -y -f x11grab -show_region 1 -s "$W"x"$H" -i :0.0+$X,$Y -filter_complex "[0:v] fps=12,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" $GIF_PATH
}

stop_rec() {
	killall ffmpeg
	xclip -selection clipboard -t image/gif -i $GIF_PATH
	kdialog --yesno 'Save?'
  if [ $? = 0 ]; then
	  path=$(kdialog --getsavefilename "$HOME"/Images/"$(date +%s)".gif)
	  mv $GIF_PATH "$path"
  fi
}

if [ "$(pidof ffmpeg)" ]; then
	stop_rec
else
	start_rec
fi
