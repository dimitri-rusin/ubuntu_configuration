#!/bin/bash

# Hole den aktuellen Batteriestand
batterystand=$(upower -i /org/freedesktop/UPower/devices/battery_CMB0 | grep percentage | awk '{print $2}' | sed 's/%//')

# Überprüfe, ob der Batteriestand unter 15% liegt
if [ $batterystand -lt 95 ]; then
  # Bildschirmgröße ermitteln
  SCREEN_WIDTH=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | awk -Fx '{print $1}')
  SCREEN_HEIGHT=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | awk -Fx '{print $2}')

  # Fenstergröße definieren (etwas kleiner als der Bildschirm)
  WINDOW_WIDTH=$(($SCREEN_WIDTH / 2))
  WINDOW_HEIGHT=$(($SCREEN_HEIGHT / 2))

  # Pfad zu deinem benutzerdefinierten, größeren Warnsymbol
  CUSTOM_ICON_PATH="/home/dimitri/code/ubuntu_configuration/fire.jpg"

  # DPI-Einstellung für größere Darstellung
  export GDK_SCALE=1
  export GDK_DPI_SCALE=8

  yad --width=$WINDOW_WIDTH --height=$WINDOW_HEIGHT \
  --title="Action necessary!" \
  --button="Battery almost empty.:0" --modal --fixed --center \
  --undecorated --on-top \
  --image="$CUSTOM_ICON_PATH" \
  --image-on-top --buttons-layout=center
