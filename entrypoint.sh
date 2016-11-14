#!/bin/sh

set -ue

err()
{
	format="$1"
	shift
	printf "$format\n" "$@" 1>&2
	exit 1
}

if [ $# -lt 3 ]; then
	err "USAGE: uid gid homedir [stack commands ...]"
fi

uid="$1"
gid="$2"
homedir="$3"
shift 3

if ! echo "$uid" | grep -Eq '^[0-9]+$'; then
	err "ERROR: uid must be one or more digits"
fi

if ! echo "$gid" | grep -Eq '^[0-9]+$'; then
	err "ERROR: gid must be one or more digits"
fi

if ! echo "$homedir" | grep -Eq '^/'; then
	err "ERROR: homedir must start with a slash"
fi


echo "stack:x:$uid:$gid:Stack User:$homedir:/bin/sh" >> /etc/passwd
echo "stack:x:$gid:" >> /etc/group
mkdir -p "$homedir"
chown $uid:$gid "$homedir"

exec sudo -u stack stack "$@"
