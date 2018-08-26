#!/bin/bash

list=$(checkupdates)

if [ "$list" == "" ]; then
    count=0
else
    count=`echo "$list" | wc -l`
fi

echo "$count"

exit 0

