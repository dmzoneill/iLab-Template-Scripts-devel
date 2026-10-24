#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		echo "${var_hostname}.${var_dnsdomain}" >/etc/HOSTNAME
		hostname "${var_hostname}.${var_dnsdomain}"
		sysctl kernel.hostname="${var_hostname}"

		{
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";"
			echo "send dhcp-lease-time 3600;"
			echo "request subnet-mask, broadcast-address, routers, interface-mtu, host-name, domain-name, domain-name-servers, nis-domain, nis-servers, nds-context, nds-servers, nds-tree-name, netbios-name-servers, netbios-dd-server, netbios-node-type, netbios-scope, ntp-servers;"
			echo "require subnet-mask;"
			echo "timeout 60;"
			echo "retry 60;"
			echo "reboot 10;"
			echo "select-timeout 5;"
			echo "initial-interval 2;"
		} >/etc/dhclient.conf

		{
			echo "STARTMODE='auto'"
			echo "DEVICE='etho'"
		} >/etc/sysconfig/ifcfg-eth0

		echo "${var_nisdomain}" >/etc/defaultdomain
	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	/etc/init.d/network restart || return 1
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
	rm /etc/profile.local
	sed -i 's/id:1:initdefault:/id:3:initdefault:/g' /etc/inittab
	sed -i 's/:\/bin\/bash -l/:\/sbin\/sulogin/g' /etc/inittab

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
