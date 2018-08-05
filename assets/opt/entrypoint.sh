#!/bin/bash
set -eu

function server_stop {
	echo ""
	echo "SERVER STOP"
#	service rsyslog stop
	exit 0
}

function server_start {
	do_init
	echo "SERVER START"
#	service rsyslog start
	sleep infinity & wait
}

function do_init {
	if ! $( id app > /dev/null 2>&1 ); then
		groupadd --gid $HGID app
		useradd --uid $HUID --gid $HUID -m -d /home/app app
	fi
}

do_init

case "${1:-}" in
	"server" )
		trap server_stop TERM
		server_start
		;;

	"root" )
		shift
		exec /opt/login.sh root
		;;

	"app" )
		shift
		exec /opt/login.sh app
		;;

	* )
		echo "USAGE: $0 [ server | root | app ]"
		exit 1
		;;
esac
