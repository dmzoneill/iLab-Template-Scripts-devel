#!/bin/bash
###############################################################################

mount -o remount,rw /
mount boot

# Set debug to 1 for no changes
###############################
var_debug=0

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		echo "${var_hostname}" >/etc/hostname
		sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/bash.bashrc
		sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"text\"/g' /etc/default/grub

		echo "Option rfc3442-classless-static-routes code 121 = array of unsigned integer 8;" >/etc/dhcp/dhclient.conf

		{
			echo "send fqdn.fqdn = \"${var_hostname}.${var_dnsdomain}.\";"
			echo "request subnet-mask, broadcast-address, time-offset, routers,"
			echo "domain-name, domain-name-servers, domain-search, host-name,"
			echo "netbios-name-servers, netbios-scope, interface-mtu,"
			echo "rfc3442-classless-static-routes, ntp-servers,"
			echo "dhcp6.domain-search, dhcp6.fqdn,"
			echo "dhcp6.name-servers, dhcp6.sntp-servers;"
		} >>/etc/dhcp/dhclient.conf

	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	/sbin/dhclient -v eth0 || return 1
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
	update-grub
	mkfifo /dev/initctl

	reboot -f
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
