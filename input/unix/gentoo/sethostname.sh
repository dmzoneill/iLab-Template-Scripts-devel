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

		echo -e "modules=\"dhclient\"" > /etc/conf.d/net
		echo -e "config_eth0=\"dhcp\"" >> /etc/conf.d/net
		echo -e "nis_domain_eth0=\"${var_nisdomain}\"" >> /etc/conf.d/net
		echo -e "nis_servers_eth0=\"nis-host nis-host1\"" >> /etc/conf.d/net

		echo "hostname=\"${var_hostname}\"" > /etc/conf.d/hostname

		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient.conf

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
	rc-update del ilab default

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



