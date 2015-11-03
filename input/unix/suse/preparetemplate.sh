#!/bin/bash
#Set hostname at start.
echo "#!/bin/bash" > /etc/profile.local
echo "/opt/ilab/sethostname.sh" >> /etc/profile.local
chmod 644 /etc/profile.local

#Set Single mode at the first boot.
sed -i 's/id:[0-9]:initdefault:/id:1:initdefault:/g' /etc/inittab
# disable root password prompt
sed -i 's/:\/sbin\/sulogin/:\/bin\/bash -l/g' /etc/inittab

# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

