#!/bin/bash

# install kernel headers and not the entire kernel source-code tree.
# apt-get install kernel-headers-`uname -r`

# install dkms
# apt-get install dkms

# prevent module from loading
# sudo blacklist cdcacm -> http://ubuntuforums.org/showthread.php?t=166624

# build cdcacm including the patch and install it
sudo rmmod cdc_acm # this is the original module, if you connect the msp430-rf2500 to the usb port
sudo rmmod cdcacm
sudo dkms uninstall -m cdcacm -v 0.1
sudo dkms remove -m cdcacm -v 0.1 --all
sudo dkms add -m cdcacm -v 0.1 -k `uname -r`
sudo dkms build -m cdcacm -v 0.1
sudo dkms install -m cdcacm -v 0.1
sudo modprobe cdcacm

# display module info
dmesg | tail -1
modinfo /var/lib/dkms/cdcacm/0.1/`uname -r`/i686/module/cdcacm.ko
