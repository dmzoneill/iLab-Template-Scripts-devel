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

		if [ -f "/etc/systemd/system/default.target" ]; then
			{
				echo "BOOTPROTO=dhcp"
				echo "ONBOOT=yes"
				echo "NM_CONTROLLED=yes"
				echo "DHCP_HOSTNAME=${var_hostname}"
				echo "DEVICE=ens32"
			} >/etc/sysconfig/network-scripts/ifcfg-ens32
		else
			{
				echo "BOOTPROTO=dhcp"
				echo "ONBOOT=yes"
				echo "NM_CONTROLLED=yes"
				echo "DHCP_HOSTNAME=${var_hostname}"
				echo "DEVICE=eth0"
			} >/etc/sysconfig/network-scripts/ifcfg-eth0
		fi

		mkdir -p /etc/dhcp
		if [ -f "/etc/init/tty.conf" ]; then
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" >/etc/dhcp/dhclient-eth0.conf
		elif [ -f "/etc/systemd/system/default.target" ]; then
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" >/etc/dhcp/dhclient-eth0.conf
		else
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" >/etc/dhclient.conf
		fi

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
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /root/.bashrc

	if [ -f "/etc/init/tty.conf" ]; then
		sed -i 's/id:[0-9]:initdefault:/id:3:initdefault:/g' /etc/inittab
	else
		if [ -f "/etc/systemd/system/default.target" ]; then
			#start in runlevel 3 (centos 7)
			systemctl set-default multi-user.target
			sed -i 's/bin\/bash/sbin\/sulogin/g' /lib/systemd/system/rescue.service
		else
			sed -i 's/^1:2345.*$/1:2345:respawn:\/sbin\/mingetty tty1/g' /etc/inittab
		fi
	fi

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
