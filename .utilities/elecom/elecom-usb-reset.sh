#!/bin/bash

elecomusb=$(lsusb | grep "Elecom" | perl -nE "/\D+(\d+)\D+(\d+).+/; print qq(\$1/\$2)")
sudo usbreset /dev/bus/usb/$elecomusb
