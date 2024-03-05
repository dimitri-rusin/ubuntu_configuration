#!/bin/bash

# Get the current battery percentage
battery_level=`cat /sys/class/power_supply/CMB0/capacity`

# Check if the battery level is 8%
if [ "$battery_level" -eq 8 ]; then
  systemctl hibernate
fi
