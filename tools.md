
Make laptop do something (like hibernate) when battery hits given percentage.
```sh
subl /home/dimitri/code/ubuntu_configuration/battery_monitor.sh

# =======================================

#!/bin/bash

# Get the current battery percentage
battery_level=`cat /sys/class/power_supply/CMB0/capacity`

# Check if the battery level is 10%
if [ "$battery_level" -eq 10 ]; then
  echo "Battery level is at 10% as of $(date)" >> /home/dimitri/BATTERY.log
fi

# =======================================

chmod +x /home/dimitri/code/ubuntu_configuration/battery_monitor.sh

# =======================================

sudo subl /etc/udev/rules.d/99-lowbattery.rules

# =======================================

SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", RUN+="/bin/bash /home/dimitri/code/ubuntu_configuration/battery_monitor.sh"

# =======================================

sudo udevadm control --reload-rules
sudo udevadm trigger
```


This program can be used to adapt some Ubuntu settings.
Adjust gsettings in a graphical user interface.
For example when you want to change the battery percentage
at which the laptop goes to sleep.
```sh
dconf Editor

sudo apt-get install dconf-editor
dconf-editor
# /org/gnome/settings-daemon/plugins/power/
```
