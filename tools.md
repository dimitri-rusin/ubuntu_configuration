Make laptop do something (like hibernate) when battery hits given percentage.
```sh
sudo subl /etc/udev/rules.d/99-lowbattery.rules

# =======================================

SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", RUN+="/bin/bash /home/dimitri/code/ubuntu_configuration/battery_monitor.sh"

# =======================================
```

```sh
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

Use GoPro 9 Black as a Webcam on Ubuntu:
```sh
https://github.com/jschmid1/gopro_as_webcam_on_linux

# Essentially:
git clone https://github.com/jschmid1/gopro_as_webcam_on_linux
sudo ./install.sh

# Unplug GoPro
sudo gopro webcam
# Plug in GoPro (via USB-C or USB-A cable)
```

```sh
crontab -e

# ===============================================
*/10 * * * * /home/dimitri/code/ubuntu_configuration/warnung_akku.sh
# ===============================================
```

Mit `udev` gab es das Problem, dass das Ubuntusystem komplett sich ausschaltete, bei 10% oder weniger. Wir sind auf `cron` umgestiegen.
