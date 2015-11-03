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
		hostname ${var_hostname}.${var_dnsdomain}
		sysctl kernel.hostname=${var_hostname}

		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhclient.conf
		echo "send dhcp-lease-time 3600;" >> /etc/dhclient.conf
		echo "request subnet-mask, broadcast-address, routers, interface-mtu, host-name, domain-name, domain-name-servers, nis-domain, nis-servers, nds-context, nds-servers, nds-tree-name, netbios-name-servers, netbios-dd-server, netbios-node-type, netbios-scope, ntp-servers;" >> /etc/dhclient.conf
		echo "require subnet-mask;" >> /etc/dhclient.conf
		echo "timeout 60;" >> /etc/dhclient.conf
		echo "retry 60;" >> /etc/dhclient.conf
		echo "reboot 10;" >> /etc/dhclient.conf
		echo "select-timeout 5;" >> /etc/dhclient.conf
		echo "initial-interval 2;" >> /etc/dhclient.conf
		
		echo "STARTMODE='auto'" > /etc/sysconfig/ifcfg-eth0
		echo "DEVICE='etho'" >> /etc/sysconfig/ifcfg-eth0

        echo "${var_nisdomain}" > /etc/defaultdomain
	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

	notice "System Initialising Networking" 5
    
	# to do
	/etc/init.d/network restart

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{		
	rm /etc/profile.local
	sed -i 's/id:1:initdefault:/id:3:initdefault:/g' /etc/inittab
	sed -i 's/:\/bin\/bash -l/:\/sbin\/sulogin/g' /etc/inittab

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


