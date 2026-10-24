#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		{
			echo -e "modules=\"dhclient\""
			echo -e "config_eth0=\"dhcp\""
			echo -e "nis_domain_eth0=\"${var_nisdomain}\""
			echo -e "nis_servers_eth0=\"nis-host nis-host1\""
		} >/etc/conf.d/net

		echo "hostname=\"${var_hostname}\"" >/etc/conf.d/hostname

		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" >/etc/dhcp/dhclient.conf

	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
	rc-update del ilab default

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
