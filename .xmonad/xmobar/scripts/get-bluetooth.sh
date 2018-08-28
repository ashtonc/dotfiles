#!/bin/bash

btstatus=$(bluetooth)

if [[ "$btstatus" == *"= off"* ]]; then
	echo ""
else
	echo "<fc=#595D64>|</fc> <fn=3></fn> "
fi

exit 0

