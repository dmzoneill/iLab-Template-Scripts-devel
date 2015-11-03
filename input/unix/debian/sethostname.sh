#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Detect if Debian 7.7
######################
VER=`grep '7.7' /etc/debian_version | wc -l`

# Save system configuration
###########################

function distro_save()
{
	if [ $var_debug -eq 0 ]; then

		echo "${var_hostname}" > /etc/hostname
		echo "${var_nisdomain}" > /etc/defaultdomain
		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient.conf
		echo "option rfc3442-classless-static-routes code 121 = array of unsigned integer 8;" >> /etc/dhcp/dhclient.conf
		if [ "${VER}" -eq "1" ]; then
			echo "fqdn.server-update on;" >> /etc/dhcp/dhclient.conf
			echo "fqdn.no-client-update on;" >> /etc/dhcp/dhclient.conf
		fi
		echo "request subnet-mask, broadcast-address, time-offset, routers,
		domain-name, domain-name-servers, domain-search, host-name,
		netbios-name-servers, netbios-scope, interface-mtu,
		rfc3442-classless-static-routes, ntp-servers;" >> /etc/dhcp/dhclient.conf

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
    # to do
    /etc/init.d/networking restart

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{
	if [ "${VER}" -eq "1" ]; then
		sed -i 's/id:1:initdefault:/id:3:initdefault:/g' /etc/inittab
		sed -i 's/~~:S:wait:\/opt\/ilab\/sethostname.sh/~~:S:wait:\/sbin\/sulogin/g' /etc/inittab
	else
    	sed -i "s/^1.*$/1:2345:respawn:\/sbin\/getty 38400 tty1/g" /etc/inittab
    	sed -i "s/\/opt\/ilab\/sethostname.*$//g" /root/.bashrc
    fi

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

