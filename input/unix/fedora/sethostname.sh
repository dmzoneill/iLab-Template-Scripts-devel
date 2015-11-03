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

		echo -e "HOSTNAME=${var_hostname}" > /etc/sysconfig/network
		echo -e "NETWORKING=yes" >> /etc/sysconfig/network
		echo -e "NISDOMAIN=${var_nisdomain}" >> /etc/sysconfig/network
		echo -e "NTPSERVERARGS=iburst" >> /etc/sysconfig/network

		echo "BOOTPROTO=\"dhcp\"" > /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "ONBOOT=\"yes\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "NM_CONTROLLED=\"yes\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "DHCP_HOSTNAME=\"$var_hostname\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0

		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient-eth0.conf
		echo "send fqdn.server-update true;" >> /etc/dhcp/dhclient-eth0.conf

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
    # fedora
    systemctl restart NetworkManager.service >/dev/null 2>&1
    /sbin/dhclient -v >/dev/null 2>&1

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{		
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /root/.bashrc

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



