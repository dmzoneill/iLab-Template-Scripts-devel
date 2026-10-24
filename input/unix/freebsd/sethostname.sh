#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0

# Save system configuration
###########################

function distro_save() {
	if [ $var_debug -eq 0 ]; then

		sed -i "" "s/hostname=.*$/hostname=\"$var_hostname\"/g" /etc/rc.conf
		sed -i "" "s/send host-name \".*\"/send host-name \"$var_hostname\"/g" /etc/dhclient.conf

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
	sed -i "" '/\/opt\/ilab\/sethostname.sh/d' /root/.cshrc
	sed -i "" '/opt\/ilab:\\/d' /etc/gettytab
	sed -i "" '/ :al=root:ht:np:sp\#115200;/d' /etc/gettytab
	sed -i "" 's/^ttyv0.*$/ttyv0 "\/usr\/libexec\/getty Pc" xterm on secure/g' /etc/ttys

	reboot
}

# Include setup dialog
ilab_common=../common.sh
[ -f /opt/ilab/common.sh ] && ilab_common=/opt/ilab/common.sh
[ -f common.sh ] && ilab_common=common.sh
# shellcheck source=../common.sh
source "${ilab_common}"
