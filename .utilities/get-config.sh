#!/bin/bash

#------------
# Program
#------------

# This simple script reads from my ~/.config/config.json file and returns the value of the requested configuration. Having this script in my path is useful for some of the other scripts I have written.

#------------
# Variables
#------------

PROGRAM_NAME="get-config.sh"
VERSION="0.1.0-prerelease"

CONFIG_FILE_PATH="/home/ashton/.config/config.json"

#------------
# Arguments
#------------

# Action flags
action_help=false
action_version=false
action_get_config=false

# Arguments collection loop
positional_args=()
argument_count=0
while [[ $# -gt 0 ]]; do
	argument="$1"
	case $argument in
		help|-h|--help)
			action_help=true
			shift
		;;
		version|--version)
			action_version=true
			shift
		;;
		*)
			positional_args+=("$1")
			shift
		;;
	esac
	((argument_count++))
done
set -- "${positional_args[@]}"

# Default action
if [ "$argument_count" = 0 ]; then
	action_help=true
fi

# JQ
if [ "$argument_count" != 0 -a "$action_help" != "true" -a "$action_version" != "true" ]; then
	action_get_config=true
fi

#------------
# Script
#------------

# Print usage/help information
if [ "$action_help" = "true" ]; then
	echo -e "\e[1mUSAGE\e[0m:"
	echo -e "    $PROGRAM_NAME \$jq_expression"
	echo -e ""
	echo -e "    Remember to escape JSON keys containing a dash. For example, the"
	echo -e "    key \".test-key\" should be written [\"test-key\"]."
fi

# Print version information
if [ "$action_version" = "true" ]; then
	echo -e "\e[1mVersion\e[0m: $VERSION"
fi

# Get the config
if [ "$action_get_config" = "true" ]; then
	jq -r "$1" "$CONFIG_FILE_PATH"
fi

# Exit with success
exit 0

