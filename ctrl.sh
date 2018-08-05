#!/bin/bash
set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

COMMANDS="build run-root run-app up down login-root login-app"

if [ ! -e "$BASEDIR/.env" ]; then
	echo "# generated at $(date +'%Y-%m-%d %H:%M:%S')" > $BASEDIR/.env
	echo "HGID=$(id -g)" >> $BASEDIR/.env
	echo "HUID=$(id -u)" >> $BASEDIR/.env
fi

do_build() {
	set -x
	exec docker-compose build
}

do_run-root() {
	set -x
	exec docker-compose run --rm app root
}

do_run-app() {
	set -x
	exec docker-compose run --rm app app
}

do_up() {
	set -x
	docker-compose up -d
	sleep 2
	docker-compose logs app
	exec docker-compose ps
}

do_login-root() {
	set -x
	exec docker-compose exec app /opt/login.sh root
}

do_login-app() {
	set -x
	exec docker-compose exec app /opt/login.sh app
}

do_down() {
	set -x
	exec docker-compose down
}

for i in $COMMANDS; do
	if [ "$i" == "${1:-}" ]; then
		shift
		do_$i $*
		exit 0
	fi
done
echo "USAGE: $0 [COMMAND]"
echo "COMMAND:"
	for i in $COMMANDS; do
	echo "  $i"
	done
exit 1


