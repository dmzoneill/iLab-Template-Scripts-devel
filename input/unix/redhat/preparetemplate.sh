#!/bin/bash

# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

VER=`grep '6.[0-9]' /etc/redhat-release | wc -l`

# redhat 5
if [ "${VER}" -eq "0" ]; then
    sed -i 's/id:[0-9]:initdefault:/id:1:initdefault:/g' /etc/inittab

    #force sethostname script to run on next boot
    echo "/opt/ilab/sethostname.sh" >> /etc/rc.sysinit

# redhat 6
else
    sed -i 's/exec \/sbin\/mingetty.*$/exec \/sbin\/mingetty --autologin root --noclear \$TTY/g' /etc/init/tty.conf
    
    #force sethostname script to run on next boot
    echo "/opt/ilab/sethostname.sh" >> /root/.bashrc
fi
