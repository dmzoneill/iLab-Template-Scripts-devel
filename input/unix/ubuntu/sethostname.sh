#!/bin/bash
###############################################################################

mount -o remount,rw /
mount boot

# Set debug to 1 for no changes
###############################
var_debug=0


# Save system configuration
###########################

function distro_save()
{
	if [ $var_debug -eq 0 ]; then

		echo "${var_hostname}" > /etc/hostname

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
	# to do
	/usr/bin/unlink /etc/resolv.conf
    /sbin/dhclient -v eth0

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{
    dpkg-reconfigure openssh-server > /dev/null 2>&1

	sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/bash.bashrc
	sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"text\"/g' /etc/default/grub 
	update-grub

	mkfifo /dev/initctl

	reboot -f
}


# Include setup dialog
######################
if [ -f common.sh ]; then
    source common.sh
elif [ -f /opt/ilab/common.sh ]; then
    source /opt/ilab/common.sh
else
    source ../common.sh
fi


