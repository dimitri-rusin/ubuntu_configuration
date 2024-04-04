#!/bin/bash

export DISPLAY=:0

# Get the current battery level
batterystand=$(upower -i /org/freedesktop/UPower/devices/battery_CMB0 | grep percentage | awk '{print $2}' | sed 's/%//')

# Get the current battery status (Charging/Discharging)
battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_CMB0 | grep state | awk '{print $2}')

# Check if the battery level is below 25% and the battery is discharging
if [ $batterystand -lt 25 ] && [ "$battery_status" = "discharging" ]; then

  SCREEN_DIMENSIONS=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}')
  if [ -z "$SCREEN_DIMENSIONS" ]; then
    echo "Cannot determine screen dimensions."
    exit 1
  fi
  SCREEN_WIDTH=$(echo $SCREEN_DIMENSIONS | awk -Fx '{print $1}')
  SCREEN_HEIGHT=$(echo $SCREEN_DIMENSIONS | awk -Fx '{print $2}')
  WINDOW_WIDTH=$(($SCREEN_WIDTH / 2))
  WINDOW_HEIGHT=$(($SCREEN_HEIGHT / 2))

  CUSTOM_ICON_PATH="/home/dimitri/code/ubuntu_configuration/fire.jpg"

  export GDK_SCALE=1
  export GDK_DPI_SCALE=8

  yad --width=$WINDOW_WIDTH --height=$WINDOW_HEIGHT \
  --button="Plugin power cord.:0" --modal --fixed --center \
  --undecorated --on-top \
  --image="$CUSTOM_ICON_PATH" \
  --image-on-top --buttons-layout=center
fi
