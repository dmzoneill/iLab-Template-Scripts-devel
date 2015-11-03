#!/bin/bash
#
echo "/opt/ilab/sethostname.sh" >> /etc/rc.d/rc.K
sed -i 's/id:[0-9]:initdefault:/id:1:initdefault:/g' /etc/inittab
sed -i 's/telinit -t 1 1/#telinit -t 1 1/g' /etc/rc.d/rc.K


# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

