#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		echo -e "${var_hostname}" >/etc/hostname

		{
			echo -e "HOSTNAME=${var_hostname}"
			echo -e "NETWORKING=yes"
			echo -e "NISDOMAIN=${var_nisdomain}"
			echo -e "NTPSERVERARGS=iburst"
		} >/etc/sysconfig/network

		{
			echo "BOOTPROTO=\"dhcp\""
			echo "ONBOOT=\"yes\""
			echo "NM_CONTROLLED=\"yes\""
			echo "DHCP_HOSTNAME=\"$var_hostname\""
		} >/etc/sysconfig/network-scripts/ifcfg-eth0

		{
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";"
			echo "send fqdn.server-update true;"
		} >/etc/dhcp/dhclient-eth0.conf

	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	systemctl restart NetworkManager.service >/dev/null 2>&1
	/sbin/dhclient -v >/dev/null 2>&1 || return 1
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /root/.bashrc

	rm -f /etc/systemd/system/default.target
	ln -s /lib/systemd/system/multi-user.target /etc/systemd/system/default.target

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
