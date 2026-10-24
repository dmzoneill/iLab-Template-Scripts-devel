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
	sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/rc.d/rc.K
	sed -i 's/id:[0-9]:initdefault:/id:3:initdefault:/g' /etc/inittab
	sed -i 's/#telinit -t 1 1/telinit -t 1 1/g' /etc/rc.d/rc.K

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
