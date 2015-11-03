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

		echo -e "${var_hostname}" > /etc/hostname

		echo -e "HOSTNAME=${var_hostname}" > /etc/sysconfig/network
		echo -e "NETWORKING=yes" >> /etc/sysconfig/network
		echo -e "NISDOMAIN=${var_nisdomain}" >> /etc/sysconfig/network
		echo -e "NTPSERVERARGS=iburst" >> /etc/sysconfig/network

		if [ -f "/etc/systemd/system/default.target" ]; then
			echo "BOOTPROTO=dhcp" > /etc/sysconfig/network-scripts/ifcfg-ens32
			echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-ens32
			echo "NM_CONTROLLED=yes" >> /etc/sysconfig/network-scripts/ifcfg-ens32
			echo "DHCP_HOSTNAME=${var_hostname}" >> /etc/sysconfig/network-scripts/ifcfg-ens32
			echo "DEVICE=ens32" >> /etc/sysconfig/network-scripts/ifcfg-ens32		
		else
			echo "BOOTPROTO=dhcp" > /etc/sysconfig/network-scripts/ifcfg-eth0
			echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth0
			echo "NM_CONTROLLED=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth0
			echo "DHCP_HOSTNAME=${var_hostname}" >> /etc/sysconfig/network-scripts/ifcfg-eth0
			echo "DEVICE=eth0" >> /etc/sysconfig/network-scripts/ifcfg-eth0
		fi

        	mkdir -p /etc/dhcp
        	if [ -f "/etc/init/tty.conf" ]; then
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient-eth0.conf
		elif [ -f "/etc/systemd/system/default.target" ]; then
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhcp/dhclient-eth0.conf
		else
			echo "send fqdn.fqdn \"${var_hostname}.${var_dnsdomain}.\";" > /etc/dhclient.conf
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
######################
if [ -f common.sh ]; then
	source common.sh
elif [ -f /opt/ilab/common.sh ]; then
	source /opt/ilab/common.sh
else
	source ../common.sh
fi



