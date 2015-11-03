#!/bin/bash
# ##############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0


# Save system configuration
#################################################################################

function save()
{
	if [ $var_debug -eq 0 ]; then

		#echo -e "${var_hostname}" > /etc/hostname
		#echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient-eth0.conf

	fi
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



