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

		sed -i "" "s/hostname=.*$/hostname=\"$var_hostname\"/g" /etc/rc.conf
		sed -i "" "s/send host-name \".*\"/send host-name \"$var_hostname\"/g" /etc/dhclient.conf  
		
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
	sed -i "" '/\/opt\/ilab\/sethostname.sh/d' /root/.cshrc 
	sed -i "" '/opt\/ilab:\\/d' /etc/gettytab
	sed -i "" '/ :al=root:ht:np:sp\#115200;/d' /etc/gettytab 
	sed -i "" 's/^ttyv0.*$/ttyv0 "\/usr\/libexec\/getty Pc" xterm on secure/g' /etc/ttys

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



