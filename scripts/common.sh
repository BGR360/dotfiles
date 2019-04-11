#!/bin/bash

set -e

scripts="./scripts/"
dotdir="./dotfiles/"

function begin() {
	echo ""
	echo "-------- Configuring $1 --------"
	echo ""
}

function end() {
	echo ""
	echo "Finished configuring $1."
	echo ""
}

function run() {
	script="${scripts}${1}.sh"
	if [[ ! -e $script ]]; then
		echo "Script $script not found."
		return 1
	fi
	if [[ ! -x $script ]]; then
		chmod +x $script
	fi
	$script
}

function confirm() {
	prompt="$1"
	full="$2"
	options="[Y/n]"
	cmdopts="-n 1 -r"
	if [[ $full = "full" ]] ; then
		cmdopts=""
		options="[yes/no]"
	fi

	while true; do
		read -p "$prompt $options " $cmdopts choice
		echo ""
		if [[ $full != "full" ]]; then
			case $choice in
				''|y|Y) return 0;;
				n|N) return 1;;
			esac
		else
			case $choice in
				[yY][eE][sS]) return 0;;
				[nN][oO]) return 1;;
			esac
		fi
		# Keep pestering them
		prompt="Please select one of"
	done
	return $RET
}

function prompt_or_default() {
	prompt=$1
	default=$2
	read -p "$prompt [$default]: "
	if [[ -z $REPLY ]]; then
		echo "$default"
	else
		echo "$REPLY"
	fi
}
