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

With regards to `/etc/NetworkManager/dispatcher.d/99-htpdate-sync`, we might get errors like:
```sh
req:1 'down' [wlp0s20f3]: find-scripts: Cannot execute '/etc/NetworkManager/dispatcher.d/99-htpdate-sync': not owned by root.
```

If you want the `/etc/NetworkManager/dispatcher.d/99-htpdate-sync` script to run at WiFi connection establishment, do:
```sh
sudo chown root:root /etc/NetworkManager/dispatcher.d/99-htpdate-sync
sudo systemctl start NetworkManager-dispatcher.service
sudo systemctl status NetworkManager-dispatcher.service
```

The root should own the file. So, we should always have:
```sh
lrwxrwxrwx 1 root root 55 Sep 16 23:13 /etc/NetworkManager/dispatcher.d/99-htpdate-sync -> /home/dimitri/code/ubuntu_configuration/99-htpdate-sync*
```

Add a line like
```
cd /work/sc122/sc122/dimitri_rusin/oll_onemax/
```
to `.profile`. Not `.bashrc`.


Change size of PDF:
```sh
pdfjam screen.pdf --paper a4paper --outfile resized_screen.pdf
```

To sign a .pdf document by inserting a picture into a file, go to:
```sh
https://www.adobe.com/acrobat/online/sign-pdf.html
```

To edit a pdf:
```sh
# When you insert typed text:
# To prevent the last few non-space characters not being visible upon downloading,
# add trailing space characters.
https://acrobat.adobe.com/link/acrobat/edit-pdf
```

Or go here. Click "Fill & Sign":
```
https://acrobat.adobe.com/link/tools/?group=group-sign
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

Restart WiFi (in case, weirdly does not connect):
```sh
sudo systemctl restart NetworkManager
```

Just currently connected WiFi's password (using fish):
```sh
set ssid (nmcli -t -f active,ssid dev wifi | string match -r '^yes.*' | string split ':' -f 2); and echo $ssid: (sudo cat /etc/NetworkManager/system-connections/$ssid.nmconnection | string match 'psk=*' | string split '=' -f 2)
```

Translate .md into .pdf:
Translate a Markdown text file into a nice-looking document or PDF file:
```sh
pandoc demande.md -o demande.pdf
```

Download YouTube.
```sh
$HOME/Videos/youtube-downloader/yt-dlp_linux -x --audio-format mp3 -o "./piper/%(title)s.%(ext)s" "https://www.youtube.com/watch?v=74Uc6gOdq9U"
```
For more code for downloading from YouTube, look at:
```sh
/home/dimitri/code/playlists/.deploy/workstory.md
```


Monitor bandwidth usage.
```sh
iftop
```

Shell configuration:
```sh
# Shell configuration file path:
subl ~/.config/fish/config.fish

# Contents:
abbr --add e 'conda activate .deploy/conda_environment/'
abbr --add r './.deploy/RUN'
abbr --add b './.deploy/BUILD'
abbr --add s 'source $HOME/code/deploy/python_setup.fish'
abbr --add upgrade 'sudo apt update &&
  sudo apt upgrade -y &&
  sudo apt full-upgrade -y &&
  sudo apt autoremove -y &&
  sudo apt autoclean &&
  sudo apt clean
'

function list_by_size
  sudo du -sh {,.}* | sort -rh
end

alias showspaces 'sed -e "s/ /␣/g" -e "s/\$/\$/"'
```

Cut video:
Get a frame:
Concatenate two videos
```sh
ffmpeg -ss 00:00:00 -to 00:00:34 -i GH010693.MP4 -c copy output.mp4
ffmpeg -ss 00:00:04.500 -i video.mp4 -frames:v 1 frame.png
ffmpeg -f concat -safe 0 -i files.txt -c copy combined.mp4
```

From concatenation, files.txt has the format:
```sh
file '/home/dimitri/Videos/My trip to Seoul.mp4'
file '/home/dimitri/Videos/My trip to Seoul [2_2].mp4'
````

Find heaviest folders or files:
```sh
sudo du -ah --max-depth=3 | sort -rh | head -n 10
```

Modify `.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap`:
```json
[
  { "keys": ["ctrl+space"], "command": "insert", "args": {"characters": "\n"} },
  { "keys": ["ctrl+alt+a"], "command": "unindent" },
  { "keys": ["ctrl+alt+s"], "command": "indent" },
  { "keys": ["alt+w"], "command": "jump_back" },
  { "keys": ["alt+shift+w"], "command": "jump_forward" },
  { "keys": ["ctrl+z"], "command": "soft_undo" },
  { "keys": ["ctrl+shift+z"], "command": "soft_redo" },
  { "keys": ["ctrl+u"], "command": "undo" },
  { "keys": ["ctrl+shift+u"], "command": "redo" },
]
```

`.config/sublime-text-3/Packages/User/Preferences.sublime-settings`
```json
  "ensure_newline_at_eof_on_save": true
```

Synology. In the browser, go to:
```
quickconnect.to/maulstein
```

Brave search engines and site search
```
Google Maps
map
https://www.google.com/maps/search/?api=1&query=%s
```

Set fish as a standard shell:
```sh
chsh -s /usr/bin/fish
```

How to save password on MBR record:
```sh
printf "%-384s" "email: XXX password: YYY recovery_codes: ZZZ" | sudo dd of=/dev/sda bs=384 count=1 seek=0
sudo dd if=/dev/sda bs=384 count=1 | hexdump -v -e '1/1 "%c"'
```

Get all files modified at most 24 hours ago:
```sh
find /var/log/apache2 -mtime 1

# -mtime n
# File's data was last modified n*24 hours ago. See the comments for -atime to understand how rounding affects the interpretation of file modification times.

-mmin n
    File's data was last modified n minutes ago.
```

List files only of size measured in Gigabyte
```sh
sudo du -hd1 . | sed -nE '/^[0-9]+(,[0-9]+)?G/p'
```

```sh
#!/usr/bin/env fish

# find . ! -executable -exec chmod 660 {} \+
# find . -executable -exec chmod 770 {} \+

find . ! -executable -exec chmod 664 {} \+
find . -executable -exec chmod 775 {} \+

# Put up an extra layer of system security on the cryptographic keys,
# that are stored using the system.
chmod 600 ~/.ssh/*
ll ~/.ssh/*

```

To list all users:
```sh
cut -d: -f1 /etc/passwd
```

To list all groups:
```sh
cut -d: -f1 /etc/group
```

To remove entries from the Sublime Text 4 Quick Switch Project list, do:
```sh
Go to: Project -> Open Recent -> Clear Items
```

Create a script for establishing a Python environment from the Nautilus window:
```sh
# Ctrl+H: Show hidden files.
# New Document: Select .conda.yaml or .INSTALL or .gitignore to create new files in the current working directory.
```


https://slides.com/
```
JavaScript slide engine
go here to make slides
go here to prepare a presentation
Hakim El Hattab
```

Nice Sublime Text packages:
```
Text Pastry: inserting consecutive numbers like 1, 2, 3
```

Find the MAC address of reMarkable tablet:
```sh
MAC: 10:2C:6B:E0:97:A2
Settings -> About -> Copyrights and Licenses
```



To connect to eduroam, check:
```
./eduroam/

Bei Zertifikat: nicht bestätigen
DHCP (nicht statisch)
```
The ca_cert "/home/dimitri/.config/cat_installer/ca.pem" is `./ca.pem`.

To connect to eduroam on Ubuntu:
```
Wi-Fi security: WPA & WPA2 Enterprise
Authentication: Protected EAP (PEAP)
Anonymous identity: anonymous@manchester.ac.uk
Domain: radius.its.manchester.ac.uk
CA certificate: No CA certificate is required
PEAP version: Automatic
Inner authentication: MSCHAPv2
Username: p84567dr@manchester.ac.uk
Password: Wgm1XgwgJUxXzP2rtUys%2GeNnExbcvTYJhjHW8AdyystpyRfx8rqyepmqrautWM
<After creating the eduroam configuration, on Identity tab, select something from the dropdown menu of MAC Address>


network={
  ssid="eduroam"
  key_mgmt=WPA-EAP
  pairwise=CCMP
  group=CCMP TKIP
  eap=PEAP
  ca_cert="/home/dimitri/.config/cat_installer/ca.pem"
  identity="p84567dr@manchester.ac.uk"
  altsubject_match="DNS:lily.its.manchester.ac.uk;DNS:radius.its.manchester.ac.uk;DNS:willow.its.manchester.ac.uk"
  phase2="auth=MSCHAPV2"
  password="Wsss"
  anonymous_identity="anonymous@manchester.ac.uk"
}

[connection]
id=eduroam
uuid=145403ea-81a1-4491-94ae-95de1d332019
type=wifi
interface-name=wlp0s20f3
permissions=

[wifi]
mac-address-blacklist=
mode=infrastructure
ssid=eduroam

[wifi-security]
key-mgmt=wpa-eap

[802-1x]
anonymous-identity=anonymous@manchester.ac.uk
ca-cert=/home/dimitri/.config/cat_installer/ca.pem
eap=peap;
identity=p84567dr@manchester.ac.uk
password=Wgm1XgwgJUxXzP2rtUys%2GeNnExbcvTYJhjHW8AdyystpyRfx8rqyepmqrautWM
phase2-auth=mschapv2

[ipv4]
dns-search=
method=auto

[ipv6]
addr-gen-mode=stable-privacy
dns-search=
method=auto

[proxy]
```
