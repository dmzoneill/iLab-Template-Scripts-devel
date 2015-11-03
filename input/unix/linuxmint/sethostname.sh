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
		sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/bash.bashrc
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"text\"/g' /etc/default/grub 

		echo "Option rfc3442-classless-static-routes code 121 = array of unsigned integer 8;" > /etc/dhcp/dhclient.conf

		echo "send fqdn.fqdn = \"${var_hostname}.${var_dnsdomain}.\";" >> /etc/dhcp/dhclient.conf
		echo "request subnet-mask, broadcast-address, time-offset, routers," >> /etc/dhcp/dhclient.conf
		echo "domain-name, domain-name-servers, domain-search, host-name," >> /etc/dhcp/dhclient.conf
		echo "netbios-name-servers, netbios-scope, interface-mtu," >> /etc/dhcp/dhclient.conf
		echo "rfc3442-classless-static-routes, ntp-servers," >> /etc/dhcp/dhclient.conf
		echo "dhcp6.domain-search, dhcp6.fqdn," >> /etc/dhcp/dhclient.conf
		echo "dhcp6.name-servers, dhcp6.sntp-servers;" >> /etc/dhcp/dhclient.conf

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
	# to do
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



