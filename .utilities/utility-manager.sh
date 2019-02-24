#!/bin/bash

#------------
# Program
#------------

# Notes
# This script manages my custom scripts and small utlity programs.
# Do not use spaces in any of the file names for now.

# Goals
# [X] Create symbolic links for utilities to /usr/local/bin
# [X] Only manage a defined subset of the utilities in this folder
# [X] Remove '.sh' from shell script endings
# [X] Also pass in the occasional binary with no '.sh'
# [X] Allow subfolders for organization
# [ ] Take config.json into account or manage with JSON
# [ ] Unlink scripts (optional)
# [ ] Run makefiles for binaries (optional)
# [ ] Manage this script with this script

# Todo
# - Look into spaces in filenames

#------------
# Variables
#------------

PROGRAM_NAME="utlity-manager.sh"
VERSION="0.1.0-alpha"

UTILITIES_CURRENT_DIRECTORY="/home/ashton/.utilities/"
UTILITIES_DESTINATION_DIRECTORY="/usr/local/bin/"

declare -a UTILITY_PATHES=(
                             "clean-path.sh"
                             "elecom/elecom-remap.sh"
                             "elecom/elecom-reset.sh"
                             "elecom/elecom-usb-reset.sh"
                             "terminal-test/magicstring.sh"
                             "terminal-test/truecolor.sh"
                             "tmux/tmux-default.sh"
                             "usbreset/usbreset"
                          )

#------------
# Arguments
#------------

# Action flags
action_help=false
action_version=false
action_link_scripts=false

# Options flags
option_verbose=false
option_quiet=false

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
		link|-l|--link)
			action_link_scripts=true
			shift
		;;
		-v|--verbose)
			option_verbose=true
			shift
		;;
		-q|--quiet)
			option_quiet=true
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

#------------
# Script
#------------

# Print usage/help information
if [ "$action_help" = "true" ]; then
	echo -e "\e[1mUsage\e[0m:"
	echo -e "    $PROGRAM_NAME (help | -h | --help)"
	echo -e "    $PROGRAM_NAME (version | --version)"
	echo -e "    $PROGRAM_NAME (link | -l | --link)"
	echo -e "\n\e[1mOptions\e[0m:"
	echo -e "    -v --verbose     Verbose output"
	echo -e "    -q --quiet       Quiet ouput"
fi

# Print version information
if [ "$action_version" = "true" ]; then
	echo -e "\e[1mVersion\e[0m: $VERSION"
fi

# Create symbolic links
if [ "$action_link_scripts" = "true" ]; then
	for entry in "${UTILITY_PATHES[@]}"; do
		if [ -e "$UTILITIES_CURRENT_DIRECTORY$entry" ]; then
			new_script_name=$(basename --suffix=.sh $entry)
			sudo ln -sf "$UTILITIES_CURRENT_DIRECTORY$entry" "$UTILITIES_DESTINATION_DIRECTORY$new_script_name"
		else
			echo "$UTILITIES_CURRENT_DIRECTORY$entry not found."
		fi
	done
fi

# Successful exit

exit 0

