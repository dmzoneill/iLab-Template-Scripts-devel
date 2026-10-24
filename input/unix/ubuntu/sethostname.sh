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

	fi
}

# Brings up the network if required
###################################

function distro_ifup() {
	notice "System Initialising Networking" 5
	/usr/bin/unlink /etc/resolv.conf
	/sbin/dhclient -v eth0 || return 1
	return 0
}

# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot() {
	dpkg-reconfigure openssh-server >/dev/null 2>&1

	sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/bash.bashrc
	sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"text\"/g' /etc/default/grub
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
