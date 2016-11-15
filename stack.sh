#!/bin/sh

set -ue

img=isolated-stack

if ! docker images | awk -vimg=$img 'BEGIN { ret=1 } NR > 1 && $1 == img { ret=0 } END { exit ret }'; then
	fullname="`readlink -e "$0"`"
	(cd "`dirname "$fullname"`" && docker build . -t $img)
fi

mkdir -p "$HOME/.stack" "$HOME/.local/bin"
docker run --rm -it -v "$HOME/.stack":"$HOME/.stack" -v "$HOME/.local/bin":"$HOME/.local/bin" -v "`pwd`":/tmp/project -w /tmp/project $img `id -u` `id -g` "$HOME" "$@"
