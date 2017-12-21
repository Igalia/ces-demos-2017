#/bin/bash
#
# Copyright (C) 2016 Igalia S.L.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

SCRIPT=`readlink -f "$0"`
SRC=`dirname "$SCRIPT"`

BACKGROUND_IMAGE=$SRC/wallpaper.png
if [ -f "$BACKGROUND_IMAGE" ]; then
    BACKGROUND_IMAGE="background-image=$BACKGROUND_IMAGE"
else
    BACKGROUND_IMAGE="\
# You may optionally specify your own background image.
# background-image=/path/to/your/wallpaper.png"
fi

OUT="$SRC/weston.ini"
if [ -f "$OUT" ]; then
    echo -n "$OUT will be overwritten. Continue [N/y]? "
    read answer
    if [ "$answer" != "y" ]; then
       exit
    fi
fi

BASH=/bin/bash
CHROME_MASH="/usr/bin/chromium --mus --no-sandbox --ozone-platform=wayland --ignore-gpu-blacklist --start-maximized"

DEFAULT_URL=https://igalia.com/
ICONS=$SRC/gnome-colors-common
RESOURCES=$SRC/resources
BIN=$SRC/bin

echo "\
[core]
repaint-window=17

[keyboard]
keymap_layout=us

[shell]
background-color=0xFFFFFFFF
locking=false
$BACKGROUND_IMAGE

# Shutdown
[launcher]
icon=$ICONS/gnome-shutdown.png
path=$BASH $BIN/shutdown.sh

# Exit all applications
[launcher]
icon=$ICONS/application-exit.png
path=$BASH $BIN/kill-apps.sh

# System Info
[launcher]
icon=$ICONS/gtk-info.png
path=$BASH $BIN/system-info.sh $RESOURCES

# Chromium/Ozone/Wayland/Mash
[launcher]
icon=$ICONS/applications-internet.png
path=$CHROME_MASH $DEFAULT_URL

# Software VS Hardware rendering demo
[launcher]
icon=$ICONS/preferences-desktop-locale.png
path=$BASH $BIN/sw-vs-hw-chrome.sh $RESOURCES

# Chromium demos
[launcher]
icon=$ICONS/meld.png
path=$CHROME_MASH file://$RESOURCES/demos.html

# Chromium demos (local demos only)
[launcher]
icon=$ICONS/meld-gray.png
path=$CHROME_MASH file://$RESOURCES/demos.html?local=true

# Weston Terminal
[launcher]
icon=$ICONS/utilities-terminal.png
path=/usr/bin/weston-terminal\
" > $OUT

echo "$OUT generated!"
echo "Copy the $OUT to /etc/xdg/weston/"
echo "And the changes will apply when weston is restarted."
echo "To restart weston, type systemctl restart weston.service"
