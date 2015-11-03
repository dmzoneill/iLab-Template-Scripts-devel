#!/bin/bash

#force sethostname script to run on next boot
echo "/opt/ilab/sethostname.sh" >> /root/.bashrc

if [ -f "/etc/init/tty.conf" ]; then
    # boot runlevel 1 (centos 6)
    sed -i 's/id:[0-9]:initdefault:/id:1:initdefault:/g' /etc/inittab
else
    if [ -f "/etc/systemd/system/default.target" ]; then
        #start in runlevel 1 (centos 7) 
        systemctl set-default rescue.target
        sed -i 's/sbin\/sulogin/bin\/bash/g' /lib/systemd/system/rescue.service
    else
        #start in runlevel 3 (centos 5) 
        sed -i 's/^1:2345.*$/1:2345:respawn:\/sbin\/mingetty --autologin root --noclear tty1/g' /etc/inittab
    fi
fi

# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules
