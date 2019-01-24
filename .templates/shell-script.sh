#!/bin/bash

#------------
# Program
#------------

# Goals

# Todo

# Notes

#------------
# Settings
#------------

#------------
# Variables
#------------

PROGRAM_NAME="shell-script.sh"
VERSION="0.0.0-prerelease"

#------------
# Arguments
#------------

# Action flags
action_help=false
action_version=false

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
	echo -e "\n\e[1mOptions\e[0m:"
	echo -e "    -v --verbose     Verbose output"
	echo -e "    -q --quiet       Quiet ouput"
fi

# Print version information
if [ "$action_version" = "true" ]; then
	echo -e "\e[1mVersion\e[0m: $VERSION"
fi

# Exit with success
exit 0

