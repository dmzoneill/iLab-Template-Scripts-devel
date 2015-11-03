#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0


# Save system configuration
###########################

function distro_save()
{
	if [ $var_debug -eq 0 ]; then

		echo -e "${var_hostname}" > /etc/hostname

		echo "NISDOMAINNAME=\"${var_nisdomain}\"" > /etc/conf.d/nisdomainname

		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhclient.conf

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
    # to do

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Chang eback to runlevel 3 and reboot
###############################################

function distro_reboot()
{
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /root/.bashrc

	sed -i 's/\/bin\/bash -l/\/sbin\/sulogin/g' /lib/systemd/system/rescue.service

	rm -f /etc/systemd/system/default.target
	ln -s /lib/systemd/system/multi-user.target /etc/systemd/system/default.target

	reboot
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



