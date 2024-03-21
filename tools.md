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

Jede 1 Minute checken [wichtig, denn Akku geht schnell leer, während Zoom-Meeting]:
```sh
crontab -e

# ===============================================
*/1 * * * * /home/dimitri/code/ubuntu_configuration/warnung_akku.sh
# ===============================================
```

Mit `udev` gab es das Problem, dass das Ubuntusystem komplett sich ausschaltete, bei 10% oder weniger. Wir sind auf `cron` umgestiegen.

This file
```sh
99-htpdate-sync
```
has some code to update the date, time, and time zone. This file can be placed (with given Linux permissions) into this following path. Then it will sync these three system components whenever the Internet connection is newly established:
```sh
/etc/NetworkManager/dispatcher.d/99-htpdate-sync
```

Add a line like
```
cd /work/sc122/sc122/dimitri_rusin/oll_onemax/
```
to `.profile`.



To sign a .pdf document by inserting a picture into a file, go to:
```sh
https://www.adobe.com/acrobat/online/sign-pdf.html
```


In the .conda.yaml file, you can put
```sh
dependencies:
  - python==3.9.18
  - pip==23.3.1
variables:
  TEST_VAR: 42
```
This will create an environment variable, that is bound to the activation of the conda environment. If you want to have a variable, that is the same across all runs within the same environment.

Find password of any known WiFi:
```sh
sudo cat /etc/NetworkManager/system-connections/*
```

Just currently connected WiFi's password (using fish):
```sh
set ssid (nmcli -t -f active,ssid dev wifi | string match -r '^yes.*' | string split ':' -f 2); and echo $ssid: (sudo cat /etc/NetworkManager/system-connections/$ssid.nmconnection | string match 'psk=*' | string split '=' -f 2)
```
