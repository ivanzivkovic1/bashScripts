#!/usr/bin/env /bin/bash
#
# Author: Dejan Djordjevic
# Creation date: 2014-10-13
# Updated by: Ivan Zivkovic;
# Update date: 2014-10-13
# Updated by: Ivan Zivkovic;
# Update date: 2020-06-07
# 
# Note:
#
#

# configuration varables

MY_VERSION=0.1
MY_DATE=$(/bin/date -d "2014-10-13" +'%B,%d %Y')
# Read variables from a file
# var1="value for var1"
# var1="value for var2"
# Optionaly you can set default values, which will be rewriten it deffined

. /path/to/some.config

# function definitions
# show_help function for displaying help information

show_help() {
cat << EOF
Usage: ${0##*/} [-h | -v] FILE...

TODO, description
TODO, options
	-h          display this help and exit
	-v          display version string and exit

EOF
}

# check for preconditions
MY_NEEDED_COMMANDS="sed awk lsof who" #list of needed commands
MISSING_COUNTER=0

for NEEDED_COMMAND in ${MY_NEEDED_COMMANDS}; do
  if ! hash "${NEEDED_COMMAND}" >/dev/null 2>&1; then
    printf "Command not found in PATH: %s\n" "${NEEDED_COMMAND}" >&2
    ((MISSING_COUNTER++))
  fi
done

if ((MISSING_COUNTER > 0)); then
  printf "Minimum %d commands are missing in PATH, aborting\n" "${MISSING_COUNTER}" >&2
  exit 1
fi


# handling script options if any 
while getopts "a:hv" opt; do
    case "$opt" in
	a)  ACTION=${OPTARG}
            ;;
        h)
            show_help
            exit 0
            ;;
        v)  
            echo "${0##*/}"
            echo "Version ${MY_VERSION}, ${MY_DATE}" && echo
            exit 0
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))"


# handling positional parameters if any
if [ "$#" -lt 1 ]; then
    show_help >&2
    exit 1
fi

# Test for mandatory options
[[ -z ${ACTION} ]] && printf "\nACTION could not be empty\n" && show_help >&2 && exit 1

exit 0
# EOF
