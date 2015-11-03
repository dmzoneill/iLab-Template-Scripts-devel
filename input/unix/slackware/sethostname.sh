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

		echo "${var_hostname}.${var_dnsdomain}" > /etc/HOSTNAME

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


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{		
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/rc.d/rc.K
	sed -i 's/id:[0-9]:initdefault:/id:3:initdefault:/g' /etc/inittab
	sed -i 's/#telinit -t 1 1/telinit -t 1 1/g' /etc/rc.d/rc.K

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


