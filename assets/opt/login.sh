#!/bin/bash
set -eu

case "${1:-}" in
	"root" )
		exec login -f root
		;;
	"app" )
		exec login -f app
		;;
	* )
		echo "USAGE: $0 [ root | app ]"
		exit 1
		;;
esac

