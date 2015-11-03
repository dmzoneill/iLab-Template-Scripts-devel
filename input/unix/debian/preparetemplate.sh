#!/bin/bash

which mingetty > /dev/null 2>&1

if [ "$?" -eq "1" ]; then
    echo "Please install mingetty"
    exit
fi

# Detect if Debian 7.7
######################
VER=`grep '7.7' /etc/debian_version | wc -l`

if [ "${VER}" -eq "1" ]; then
	sed -i 's/id:[0-9]:initdefault:/id:1:initdefault:/g' /etc/inittab
	sed -i 's/~~:S:wait:.*/~~:S:wait:\/opt\/ilab\/sethostname.sh/g' /etc/inittab
else
	sed -i "s/^1.*$/1:2345:respawn:\/sbin\/mingetty --autologin root tty1/g" /etc/inittab
	echo "/opt/ilab/sethostname.sh" >> /root/.bashrc
fi



# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules
