#/usr/bin/bash
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

CHROME="/usr/bin/chromium"
CHROME_MUS="$CHROME --mus --no-sandbox --ignore-gpu-blacklist --ozone-platform=wayland --start-maximized --disable-infobars"
WESTON_IMAGE="/usr/bin/weston-image"

LIST_OF_TESTS=$RESOURCES/sw-vs-hw-tests.txt
TEST_DURATION=10
let SLEEP_DURATION=$TEST_DURATION*2
RESULT_DURATION=5
SHUTDOWN_DURATION=2 # This is necessary to avoid Wayland crashes.

BROWSERBENCH_URL="http://browserbench.org/MotionMark/developer.html?test-interval=$TEST_DURATION&display=minimal&tiles=big&controller=ramp&frame-rate=50&kalman-process-error=1&kalman-measurement-error=4&time-measurement=performance"

while :
do

while read -r line
do

canonicalLine=`echo $line | sed 's/\#.*$//g' | sed 's/[ \t]//g' | sed 's/,/ /g'`
if [ -z "$canonicalLine" ]; then
   continue
fi

read -r -a r <<< "$canonicalLine"

SUITENAME="${r[0]}"
TESTNAME="${r[1]}"

echo "Running $SUITENAME/$TESTNAME..." 1>&2
URL="$BROWSERBENCH_URL&suite-name=$SUITENAME&test-name=$TESTNAME"

$CHROME_MUS $URL &
sleep $SLEEP_DURATION
sleep $RESULT_DURATION
pkill --oldest --signal TERM -f chromium # killing by pid does not seem enough
sleep $SHUTDOWN_DURATION

done < "$LIST_OF_TESTS"

done
