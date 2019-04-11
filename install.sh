#!/bin/bash

# Source common
. scripts/common.sh

if [[ $# -lt 1 ]]; then
	echo -e "Usage: ./install.sh <command> [<command> ...]"
	echo -e ""
	echo -e "Available commands:"
	echo -e "\t- all"
	echo -e "\t- vim"
	echo -e "\t- tmux"
	echo -e "\t- git"
	exit 1
fi

while [[ $# -gt 0 ]]; do
	case "$1" in
		vim)
			run "vim"
			;;
		tmux)
			run "tmux"
			;;
		git)
			run "git"
			;;
		all)
			run "vim"
			run "tmux"
			run "git"
			;;
		*)
			echo "Unknown command $1"
			;;
	esac
	shift
done
