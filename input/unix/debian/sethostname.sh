#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Detect if Debian 7.7
######################
VER=$(grep -c '7.7' /etc/debian_version)

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		echo "${var_hostname}" >/etc/hostname
		echo "${var_nisdomain}" >/etc/defaultdomain
		{
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";"
			echo "option rfc3442-classless-static-routes code 121 = array of unsigned integer 8;"
		} >/etc/dhcp/dhclient.conf
		if [ "${VER}" -eq "1" ]; then
			{
				echo "fqdn.server-update on;"
				echo "fqdn.no-client-update on;"
			} >>/etc/dhcp/dhclient.conf
		fi
		echo "request subnet-mask, broadcast-address, time-offset, routers,
		domain-name, domain-name-servers, domain-search, host-name,
		netbios-name-servers, netbios-scope, interface-mtu,
		rfc3442-classless-static-routes, ntp-servers;" >>/etc/dhcp/dhclient.conf

	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	/etc/init.d/networking restart || return 1
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
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
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
