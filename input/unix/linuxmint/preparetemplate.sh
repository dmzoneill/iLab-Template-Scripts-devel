#!/bin/bash
#SET HOSTNAME SCRIPT TO START ON NEXT BOOT
echo "/opt/ilab/sethostname.sh" >> /etc/bash.bashrc
#EDIT DEFAULT GRUB TO START IN SINGLE USER MODE ON NEXT BOOT
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash init\=\/bin\/bash\"/g' /etc/default/grub 
update-grub

# delete udev rules
rm -rvf /etc/udev/rules.d/70-persistent-net.rules

