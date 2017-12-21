# Demos for CES 2018

This repository contains demos of Chromium running on AGL that are intended
to be used at [CES](https://www.ces.tech/) 2018. They have been tested on
Renesas's
[R-Car M3](https://www.renesas.com/en-us/solutions/automotive/products/rcar-m3.html)
and on a [RaspberryPi 2/3](https://www.raspberrypi.org/).
You need an
[agl-platform-demo](https://wiki.automotivelinux.org/agl-distro)
image containing a pre-installed chromium browser, compiled using
[Igalia's meta-browser](https://github.com/Igalia/meta-browser) fork.
You must also copy this `ces-demos-2017/` folder on your AGL disk (/home/ folder).

In a running AGL session, open a shell and execute `install.sh` to generate your
`/home/ces-demos-2017/weston.ini` file.

After reboot, you will see some launcher icons in the top panel that you can
use to start applications, to shutdown the computer etc If you have passed
an image to the install script then it will be used as a wallpaper.
