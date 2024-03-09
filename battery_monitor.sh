#!/usr/bin/env bash

# Get the current battery percentage
battery_level=`cat /sys/class/power_supply/CMB0/capacity`

case $battery_level in 11|10|9|8|7|6|5|4|3|2|1) pm-hibernate;; esac
