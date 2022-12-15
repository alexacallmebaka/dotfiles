#!/bin/sh
preview() {
	cat <<-EOF | paste -sd '' >"$LF_UEBERZUG_FIFO"
	{
	"action": "add", "identifier": "lf-preview",
	"path": "$1", "x": $4, "y": $5, "width": $2, "height": $3,
	"scaler": "contain"
	}
	EOF
}

#clean active preview
lf-ueberzug-cleaner 

#preview active file
file="$1"; shift
case "${file,,}" in
  *.mp4|*.mkv|*.mp3|*.flac|*.m4v) mediainfo "$file";;
  *.pdf)
	thumbnail="$LF_UEBERZUG_TEMPDIR/thumbnail.png"
	gs -o "$thumbnail" -sDEVICE=pngalpha -dLastPage=1 "$file" >/dev/null
	preview "$thumbnail" "$@"
	;;
  *.jpg|*.jpeg|*.png|*.bmp|*.nef) preview "$file" "$@";;
  *.svg)
	thumbnail="$LF_UEBERZUG_TEMPDIR/thumbnail.png"
	convert "$file" "$thumbnail"
	preview "$thumbnail" "$@"
	;;
  *.tar.gz) tar -tf "$file";;
  *) highlight "$file" -O ansi --force;;
esac

return 127 # nonzero retcode required for lf previews to reload
