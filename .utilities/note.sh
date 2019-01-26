#!/bin/bash

# - note
#     - show last few notes
# - note -s|-l|--show|--list N
#     - show last N notes
# - note ...
#     - append new note

DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "$DATE - $@"

