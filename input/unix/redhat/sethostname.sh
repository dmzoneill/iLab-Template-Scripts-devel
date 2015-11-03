#!/bin/bash
###############################################################################

# Set debug to 1 for no changes
###############################
var_debug=0


# Save system configuration
###########################

function distro_save()
{
	if [ $var_debug -eq 0 ]; then

		echo -e "HOSTNAME=${var_hostname}" > /etc/sysconfig/network
		echo -e "NETWORKING=yes" >> /etc/sysconfig/network
		echo -e "NISDOMAIN=${var_nisdomain}" >> /etc/sysconfig/network
		echo -e "NTPSERVERARGS=iburst" >> /etc/sysconfig/network

		echo "BOOTPROTO=\"dhcp\"" > /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "ONBOOT=\"yes\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "NM_CONTROLLED=\"yes\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		echo "DHCP_HOSTNAME=\"${var_hostname}\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
        echo "DEVICE=\"eth0\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0

        VER=`grep '5.[0-9]' /etc/redhat-release | wc -l`

        if [ "${VER}" -eq "1" ]; then   
		    echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhclient-eth0.conf
        else
            mkdir -p /etc/dhcp
    		echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient-eth0.conf
        fi

	fi
}


# Brings up the network if required
###################################

function distro_ifup()
{
	local RETVAL=0;

    notice "System Initialising Networking" 5
    
	# to do
    /etc/init.d/network restart

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


# reboot - Change back to runlevel 3 and reboot
###############################################

function distro_reboot()
{
    VER=`grep '5.[0-9]' /etc/redhat-release | wc -l`
    
    if [ "${VER}" -eq "1" ]; then   
    	sed -i 's/id:[0-9]:initdefault:/id:3:initdefault:/g' /etc/inittab
        sed -i '/\/opt\/ilab\/sethostname.sh/d' /etc/rc.sysinit 
    else
	    sed -i 's/exec \/sbin\/mingetty.*$/exec \/sbin\/mingetty \$TTY/g' /etc/init/tty.conf
        sed -i '/\/opt\/ilab\/sethostname.sh/d' /root/.bashrc 
    fi

	reboot
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

