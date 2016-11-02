#!/bin/sh

set -ue

wd="`pwd`"

img=isolated-stack

if ! docker images | awk -vimg=$img 'BEGIN { ret=1 } NR > 1 && $1 == img { ret=0 } END { exit ret }'; then
	fullname="`readlink -e "$0"`"
	cd "`dirname "$fullname"`"
	docker build . -t $img
fi

docker run --rm -it -v "$HOME/.stack":/tmp/.stack -v "$HOME/.local/bin":/tmp/.local/bin -v "$wd":/tmp/project -w /tmp/project --user=`id -u`:`id -g` $img "$@"
