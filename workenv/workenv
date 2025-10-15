#!/usr/bin/env bash

WORK_ENV_DIR="$HOME/dotfiles/workenv/envs"

usage() {
	
	echo "Usage: $0 <environment>"
	echo
	echo "Available environments:"
	
	for env in "$WORK_ENV_DIR/*.sh"; do
		echo "	- " $(basename ${env%.sh})
	done
	exit 1
}

[ -z "$1" ] && usage

ENV_NAME="$1"
ENV_SCRIPT="$WORK_ENV_DIR/$ENV_NAME.sh"

if [ ! -f "$ENV_SCRIPT" ]; then
	echo "Error: Environment $ENV_NAME not found."
	usage
fi

bash "$ENV_SCRIPT"
