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

RESOURCES=$1

IP=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
BOOT_TIME=`cut -d: -f1 /proc/uptime | awk '{ print $1}'`

/usr/bin/chromium --mus --no-sandbox --ozone-platform=wayland --ignore-gpu-blacklist --disable-infobars  "file://$RESOURCES/system-info.html?ip=$IP&bootTime=$BOOT_TIME"
