#!/bin/bash

wifistatus=$(wifi)

if [[ "$wifistatus" == *"= off"* ]]; then
	echo "<fn=2></fn>"
else
	echo "<fn=2></fn>"
fi

exit 0

