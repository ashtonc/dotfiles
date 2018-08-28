#!/bin/sh
# Removes duplicate entries from my path

PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

