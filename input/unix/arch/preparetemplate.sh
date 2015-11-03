#!/bin/bash

echo "/opt/ilab/sethostname.sh" >> /root/.bashrc
rm -f /etc/systemd/system/default.target
ln -s /lib/systemd/system/runlevel1.target /etc/systemd/system/default.target
sed -i 's/\/sbin\/sulogin/\/bin\/bash -l/g' /lib/systemd/system/rescue.service
# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

