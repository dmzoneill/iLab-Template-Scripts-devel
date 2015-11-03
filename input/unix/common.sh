#!/bin/bash
#======================================================================================
# FILE: common.sh
# USAGE: source common.sh
#
# DESCRIPTION: Distribution specific sethostname.sh should include the line: 
#              source common.sh
#              After execution a set of 'global' variables will be available.
#              These variables are defined in the next section.                
#
# AUTHOR: "O Neill, David M" <david.m.oneill@intel.com>
# AUTHOR: "Redlarski, Michal" <michal.redlarski@intel.com>
# COMPANY: Intel - Engineering Computing
# PROJECT: iLab Sysprep Scripts
#======================================================================================

#--------------------------------------------------------------------------------------
# Common Variables
#--------------------------------------------------------------------------------------

ilabdir="/opt/ilab"

# testing confirm dialogs
nodes_confirm=0
vas_confirm=1

var_networkup=0
sed_suffix=""

ssh_user="ecilabnodes"
ssh_pubkey="${ilabdir}/ecilab"

vas_download="https://github.intel.com/IT-EngineeringComputing/kerberos-client-config/raw/master/install.sh"
var_os=""
var_arch=""
var_distro=""
var_distro_version=""

var_hostname=""
var_nisdomain=""
var_dnsdomain=""
var_addomain=""
var_shortcode=""
var_fullname=""

var_proxyhost=""
var_proxyport=""
var_automaster=""
var_nishost1=""
var_nishost2=""
var_mailhost=""
var_ntphost1=""
var_ntphost2=""
var_ntphost3=""
var_nodeshost=""

#--------------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------------

#=== FUNCTION =========================================================================
# NAME: log
# DESCRIPTION: Logs string to a text file
# PARAMETER 1: the string to log 
#======================================================================================

function log()
{
    if [ -f ${ilabdir}/ilablog ]; then
        echo "$1" >> ${ilabdir}/ilablog
    else
        echo "$1" > ${ilabdir}/ilablog
    fi
}


#=== FUNCTION =========================================================================
# NAME:  askdialog
# DESCRIPTION: Asks a yes/no question via a dialog
# PARAMETER 1: The title of the dialog
# PARAMETER 2: The question to be asked
# RETURN: 1/0
#======================================================================================

function askdialog()
{
    local RETVAL=0;
    DIALOG=${DIALOG=dialog}

    $DIALOG --title "$1" --clear --yesno "$2" $3 60

    case $? in
        0)
            RETVAL=1;;
    esac

    log "Question: $2"
    log "Answer: $RETVAL"

    return $(($RETVAL))
}


#=== FUNCTION =========================================================================
# NAME: confirm
# DESCRIPTION: Prompts the user to acknowledge a statement message
# PARAMETER 1: The title of the dialog
# PARAMETER 2: The statement to be ackowledged
#======================================================================================

function confirm()
{
    DIALOG=${DIALOG=dialog}
    $DIALOG --title "$1" --msgbox "$2" 12 60
    log "Confirm: $2"
}


#=== FUNCTION =========================================================================
# NAME: notice
# DESCRIPTION: Display a message with a countdown
# PARAMETER 1: The message to display
# PARAMETER 2: The amount fo seconds the message should be displayed
#======================================================================================

function notice()
{
    local LEN=${#1}
    LEN=$(($LEN + 6))
    DIALOG=${DIALOG=dialog}
    $DIALOG --nocancel --nook --pause " $1 " 9 ${LEN} $2
    log "Notice: $1"
}


#=== FUNCTION =========================================================================
# NAME: distro_detection
# DESCRIPTION: Detects the Os/Distro/Version and updates the global vars
#======================================================================================

function distro_detection()
{
	log "Os detection..."
	
	var_os=`uname -s | tr '[A-Z]' '[a-z]'`
	local rev=`uname -r | tr '[A-Z]' '[a-z]'`
	local mach=`uname -m | tr '[A-Z]' '[a-z]'`
	
	if [[ "${mach}" == "x86_64" || "${mach}" == "amd64" ]] ; then
		var_arch=64
	else
		var_arch=32
	fi

	if [ "${var_os}" == "freebsd" ] ; then
		var_distro_version=`echo ${rev} | sed 's/[^[0-9.]//g'`
		var_distro="freebsd"
        sed_suffix="\"\""
		
	elif [ "${var_os}" == "linux" ] ; then
	
		if [ -f /etc/redhat-release ] ; then
			var_distro="redhat"
			var_distro_version=`cat /etc/redhat-release | sed 's/[^[0-9.]//g'`
			
		elif [ -f /etc/SuSE-release ] ; then
			var_distro="suse"
			var_distro_version=`cat /etc/SuSE-release | grep 'VERSION =.*' | awk -F= '{print $2}' | tr -d ' '`
				
		elif [ -f /etc/fedora-release ] ; then
			var_distro="fedora"
			var_distro_version=`echo /etc/fedora-release | sed 's/[^[0-9.]//g'`
	
		elif [ -f /etc/centos-release ] ; then
			var_distro="centos"
			var_distro_version=`echo /etc/centos-release | sed 's/[^[0-9.]//g'`

		elif [ -f /etc/slackware-release ] ; then
			var_distro="slackware"
			var_distro_version=`cat /etc/slackware-release | grep 'VERSION_ID=.*' | awk -F= '{print $2}'`

		elif [ -f /etc/arch-release ] ; then
			var_distro="arch"
			
		elif [ -f /etc/gentoo-release ] ; then
			var_distro="gentoo"
			
		elif [ -f /etc/debian_version ] ; then
			var_distro="debian"
			var_distro_version=`cat /etc/debian_version`
			
		elif [ -f /etc/lsb-release ] ; then
			# Mint or Ubuntu
		
			local lsbid=`cat /etc/lsb-release | grep 'DISTRIB_ID=.*' | awk -F= '{print $2}'`
			var_distro_version=`cat /etc/lsb-release | grep 'DISTRIB_RELEASE=.*' | awk -F= '{print $2}'`
						
			if [ "${distroid}" == "Ubuntu" ] ; then
				var_distro="ubuntu"
				
			elif [ "${distroid}" == "LinuxMint" ] ; then
				var_distro="linuxmint"
			
			fi
			
		fi
	fi
	
	log "OS: $var_os"
	log "Arch: $var_arch"
	log "Distro: $var_distro"
	log "Distro version: $var_distro_version"
}


#=== FUNCTION =========================================================================
# NAME: ntp_setup
# DESCRIPTION: Sets up a simple ntp updater
#======================================================================================

function ntp_setup()
{
	local RETVAL=0;

    notice "Configuring NTP and updating the time" 5
    ntpdate=`which ntpdate`
    echo "0 */1 * * * root ${ntpdate} ${var_ntphost1}.${var_dnsdomain} >/dev/null 2>&1" > /etc/cron.d/timeupdater
    ${ntpdate} ${var_ntphost1}.${var_dnsdomain} >> ${ilabdir}/ilablog 2>&1

	if [ "$?" -ne "0" ]; then
		RETVAL=1
	fi

	return $(($RETVAL))
}


#=== FUNCTION =========================================================================
# NAME: vas_setup
# DESCRIPTION: The main vas setup function
#======================================================================================

function vas_setup()
{
    if [ "${vas_confirm}" -eq "1" ]; then

        vas_ask_msg1="\nDo you require this machine to work on the windows domain? \n\n"
        vas_ask_msg2="1) The Vintela Authentication Services(VAS) plugin for Pluggable Authentication Module(PAM) will be installed\n\n"
        vas_ask_msg3="2) This linux machine will attempt to join the ${vas_ad_capital} domain.\n\n"
        vas_ask_msg4="3) User logins will authenticate against active directory"
        vas_ask_msg="${vas_ask_msg1} ${vas_ask_msg2} ${vas_ask_msg3} ${vas_ask_msg4}"

        askdialog "iLab: VAS Setup" "${vas_ask_msg}" 17

    	# confirm they want to setup vas
        if [ "$?" -eq "0" ]; then
	    	return 1
    	fi
    else
    	return
    fi

	# Bring up the network
    if [ "${var_networkup}" -eq "0" ]; then

        distro_ifup

        if [ "$?" -ne "0" ]; then
		    confirm "Error" "Failed to bring up network. Contact EC support"
    		return 1
	    fi

        var_networkup=1
    fi

	# Update current time
	log "Updating time"
	ntp_setup

	if [ "$?" -ne "0" ]; then
		confirm "Error" "Failed to update the time. Contact EC support"
		return 1
	fi

	# VAS scripts download
	wget_bin=`which wget`
	log "Downloading from ${vas_download}"
	notice "Downloading VAS installation script" 5
	$wget_bin --no-proxy -a ${ilabdir}/ilablog ${vas_download} -O ${ilabdir}/install.sh

	#VAS installation
    if [ -e "${ilabdir}/install.sh" ]; then
		vas_install_cmd="${ilabdir}/install.sh -s ${var_shortcode} --ilab -h ${var_hostname}.${var_dnsdomain}"
		log "Executing ${vas_install_cmd}"
		chmod +x ${ilabdir}/install.sh
		notice "Setting up VAS may take longer then 2 minutes" 120 &
		${ilabdir}/install.sh -s ${var_shortcode} --ilab -h ${var_hostname}.${var_dnsdomain} >> ${ilabdir}/ilablog 2>&1
	fi
}


#=== FUNCTION =========================================================================
# NAME: site_choice
# DESCRIPTION: The site choice dialog, sets up global vars
#======================================================================================

function site_choice()
{
    SITE_PROMPT="Please choose the working site:"
    counter=1
    endcounter=$(( var_sitecount + 1))

    SITE_CHOICES=""
    while [ $counter -lt $endcounter ]; do
        TEXT=$(printf "%-4s %-17s %-14s" "${addomain[ $counter ]}" "${fullname[ $counter ]}" "${dnsdomain[ $counter ]}")
        SITE_CHOICES=( "${SITE_CHOICES[@]}" "$counter" "$TEXT" )
        counter=$(( counter + 1 ))
    done


    SITE_DIALOG=${SITE_DIALOG=dialog}
    domaintempfile=`sitetempfile 2>/dev/null` || sitetempfile=/tmp/sitetest$$
    trap "rm -f $sitetempfile" 0 1 2 5 15
    retval=255

    IFS=$'\n'
    while [ $retval != 0 ]; do
        $SITE_DIALOG --clear --title "iLab: Virtual Machine Setup" --nocancel --menu "${SITE_PROMPT}" 20 51 12 ${SITE_CHOICES[@]} 2> $sitetempfile
        retval=$?
        choice=`cat $sitetempfile`
    done

    log "Site selection: $choice"
}


#=== FUNCTION =========================================================================
# NAME: hostname_setup
# DESCRIPTION: Dialog prompt for the user inputted hostname
#======================================================================================

function hostname_setup()
{
    HOST_DIALOG=${HOST_DIALOG=dialog}
    hosttempfile=`tempfile 2>/dev/null` || hosttempfile=/tmp/hosttest$$
    trap "rm -f $hosttempfile" 0 1 2 5 15

    local local_title="iLab: Virtual Machine Setup"
    local local_good_name="A good name consists of:\n\n1) Site Code \n2) L for lab \n3) V for virtual \n4) ...\n\nsilv-software1, bwlv-csacker, gklv-collecto2"
    local local_host_prompt="Please enter the hostname for this machine:\n\n$local_good_name"
    local local_host_prompt2="Please try a different name:\n\n$local_good_name"
    local local_error_alphanum="Hostname must be alpha-numeric, please enter a hostname:"
    local local_ok=0
    local local_sitespecific=""
    local local_nonalpha=""
    local local_regex='^'${dnsprefix[ $choice ]}'[a-zA-Z0-9\-]\+$'

    while [ "$local_ok" -eq "0" ]; do

        if [ -z "${var_hostname}" ]; then
            $HOST_DIALOG --title "${local_title}" --nocancel --clear --inputbox "${local_host_prompt}" 16 51 "${dnsprefix[$choice]}" 2> $hosttempfile
        elif [[ "$var_hostname" = "$local_nonalpha" && "$var_hostname" = "$local_sitespecific" ]]; then
            local_ok=1
            break
        elif [ "$var_hostname" != "$local_sitespecific" ]; then
            $HOST_DIALOG --title "${local_title}" --nocancel --clear --inputbox "${local_host_prompt2}" 16 51 "${dnsprefix[$choice]}" 2> $hosttempfile
        else
            $HOST_DIALOG --title "${local_title}" --nocancel --clear --inputbox "${local_error_alphanum}" 16 51 "${dnsprefix[$choice]}" 2> $hosttempfile
        fi

        var_hostname=`cat $hosttempfile`;
        local_nonalpha=$(echo $var_hostname | grep '^[a-zA-Z0-9\-]\+$')
        local_sitespecific=$(echo $var_hostname | grep $local_regex)
    
    done

    log "Machine name: $var_hostname"

	distro_save 
}


#=== FUNCTION =========================================================================
# NAME: nisclient_setup
# DESCRIPTION: Sets up the yp.conf for distributions that don't read dhcp nis-servers
#======================================================================================

function nisclient_setup()
{
	notice "Configuring System For Network Information Services" 3
    log "Configuring nis"

    if [ "${var_os}" == "freebsd" ]; then

        log "Configuring /etc/rc.conf"

        grep nis_client_enable /etc/rc.conf >/dev/null
        local nisenabled=$?
        grep nis_client_flags /etc/rc.conf >/dev/null
        local nisconfigured=$?

        if [ "${nisenabled}" == "1" ]; then
            echo "nis_client_enable=\"YES\"" >> /etc/rc.conf
            log "echo \"nis_client_enable=\"YES\"\" >> /etc/rc.conf"
        else
            sed -i $sed_suffix 's/nis_client_enable=\".*\"/nis_client_enable=\"YES\"/g' /etc/rc.conf
            log "sed -i \"\" 's/nis_client_enable=\".*\"/nis_client_enable=\"YES\"/g' /etc/rc.conf"
        fi

        if [ "${nis_client_flags}" == "1" ]; then
            echo "nis_client_flags=\"-ypset -s -m -S ${var_nisdomain},${var_nishost1},${var_nishost2}\"" >> /etc/rc.conf
            log "echo \"nis_client_flags=\"-ypset -s -m -S ${var_nisdomain},${var_nishost1},${var_nishost2}\"\" >> /etc/rc.conf"
        else
            sed -i $sed_suffix "s/nis_client_flags=\".*\"/nis_client_flags=\"-ypset -s -m -S ${var_nisdomain},${var_nishost1},${var_nishost2}\"/g" /etc/rc.conf
            log "sed -i \"\" \"s/nis_client_flags=\".*\"/nis_client_flags=\"-ypset -s -m -S ${var_nisdomain},${var_nishost1},${var_nishost2}\"/g\" /etc/rc.conf"
        fi

    else
	    
        log "Configuring /etc/yp.conf"
    	echo "# iLab Generated" > /etc/yp.conf
    	echo "domain ${var_nisdomain} server ${var_nishost1}.${var_dnsdomain}" >> /etc/yp.conf
    	echo "domain ${var_nisdomain} server ${var_nishost2}.${var_dnsdomain}" >> /etc/yp.conf
    	echo "" >> /etc/yp.conf
	
    	log "echo \"# iLab Generated\" > /etc/yp.conf"
    	log "echo \"domain ${var_nisdomain} server ${var_nishost1}.${var_dnsdomain}\" > /etc/yp.conf"
	    log "echo \"domain ${var_nisdomain} server ${var_nishost2}.${var_dnsdomain}\" >> /etc/yp.conf"
    	log "echo \"\" >> /etc/yp.conf"
    fi
}


#=== FUNCTION =========================================================================
# NAME: autofs_setup
# DESCRIPTION: Sets up the auto.master 
#======================================================================================

function autofs_setup()
{
	log "Configuring /etc/auto.master"
	notice "Configuring System For Automounting" 3

    if [ "${var_os}" == "freebsd" ]; then
        log "Freebsd detected, incompatible with autofs, quitting configuration...."
        return 0
    fi
	
	echo "# iLab Generated" > /etc/auto.master
	
	echo "${var_automaster}" >> /etc/auto.master
	echo "" >> /etc/auto.master
	
	log "echo \"# iLab Generated\" > /etc/auto.master"
	log "echo \"${var_automaster}\" >> /etc/auto.master"
	log "echo \"\" >> /etc/auto.master"
}


#=== FUNCTION =========================================================================
# NAME: proxy_setup
# DESCRIPTION: Sets up the system and or user shell proxies 
#======================================================================================

function proxy_setup()
{
	log "Configuring proxies"
	notice "Configuring System To Use Proxies" 3
	
	local find="PROXY_ENABLED=\".*\""
	local replace="PROXY_ENABLED=\"yes\""
	local noproxy="127.0.0.1,localhost,.intel.com"
	
	if [ -f /etc/sysconfig/proxy ]; then
	
		log "Configuring /etc/sysconfig/proxy"
		find="PROXY_ENABLED=\".*\""
		replace="PROXY_ENABLED=\"yes\""
		sed -i $sed_suffix "s/${find}/${replace}/g" /etc/sysconfig/proxy
	
		find="HTTP_PROXY=\".*\""
		replace="HTTP_PROXY=\"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}/\""
		sed -i $sed_suffix "s/${find}/${replace}/g" /etc/sysconfig/proxy
		
		find="HTTPS_PROXY=\".*\""
		replace="HTTPS_PROXY=\"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}/\""
		sed -i $sed_suffix "s/${find}/${replace}/g" /etc/sysconfig/proxy
		
		find="FTP_PROXY=\".*\""
		replace="FTP_PROXY=\"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}/\""
		sed -i $sed_suffix "s/${find}/${replace}/g" /etc/sysconfig/proxy
		
		find="NO_PROXY=\".*\""
		replace="NO_PROXY=\"${noproxy}\""
		sed -i $sed_suffix "s/${find}/${replace}/g" /etc/sysconfig/proxy
		
	elif [ -f /root/.bashrc ]; then
	
		log "Configuring /root/.bashrc"
		sed -i $sed_suffix '/export http_proxy.*/d' /root/.bashrc
		sed -i $sed_suffix '/export https_proxy.*/d' /root/.bashrc
		sed -i $sed_suffix '/export ftp_proxy.*/d' /root/.bashrc
		sed -i $sed_suffix '/export rsync_proxy.*/d' /root/.bashrc
		sed -i $sed_suffix '/export no_proxy.*/d' /root/.bashrc
		
		echo "export http_proxy=http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}" >> /root/.bashrc
		echo "export https_proxy=http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}" >> /root/.bashrc
		echo "export ftp_proxy=http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}" >> /root/.bashrc
		echo "export rsync_proxy=http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}" >> /root/.bashrc
		echo "export no_proxy=${noproxy}" >> /root/.bashrc

    elif [ -f /root/.cshrc ]; then

		log "Configuring /root/.cshrc"
		sed -i $sed_suffix '/setenv HTTP_PROXY.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv HTTPS_PROXY.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv FTP_PROXY.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv RSYNC_PROXY.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv NO_PROXY.*/d' /root/.cshrc
		
		sed -i $sed_suffix '/setenv http_proxy.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv https_proxy.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv ftp_proxy.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv rsync_proxy.*/d' /root/.cshrc
		sed -i $sed_suffix '/setenv no_proxy.*/d' /root/.cshrc

		echo "setenv HTTP_PROXY \"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}\"" >> /root/.cshrc
		echo "setenv HTTPS_PROXY \"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}\"" >> /root/.cshrc
		echo "setenv FTP_PROXY \"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}\"" >> /root/.cshrc
		echo "setenv RSYNC_PROXY \"http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}\"" >> /root/.cshrc
		echo "setenv NO_PROXY \"${noproxy}\"" >> /root/.cshrc

		echo "setenv http_proxy \"\$HTTP_PROXY\"" >> /root/.cshrc
		echo "setenv https_proxy \"\$HTTPS_PROXY\"" >> /root/.cshrc
		echo "setenv ftp_proxy \"\$FTP_PROXY\"" >> /root/.cshrc
		echo "setenv rsync_proxy \"\$RSYNC_PROXY\"" >> /root/.cshrc
		echo "setenv no_proxy \"\$NO_PROXY\"" >> /root/.cshrc

	fi
	
	if [ -f /etc/yum.conf ]; then
	
		log "Configuring /etc/yum.conf"
		sed -i $sed_suffix '/proxy=.*/d' /etc/yum.conf
		echo "proxy=http://${var_proxyhost}.${var_dnsdomain}:${var_proxyport}" >> /etc/yum.conf
		
	fi
	
}


#=== FUNCTION =========================================================================
# NAME: mail_setup
# DESCRIPTION: Sets up the system for sendmail 
#======================================================================================

function mail_setup()
{
    local conffile="/etc/mail/sendmail.mc"
    local outfile="/etc/mail/sendmail.cf"

	notice "Configuring System for Sendmail" 3
	
	which m4 > /dev/null 2>&1
	havem4=$?
	
	if [ -f $conffile ]; then
	
		local find=".*SMART_HOST.*"
		local replace="define\(\`SMART_HOST\', \`${var_mailhost}.\$m\'\)dnl"
		sed -i $sed_suffix "s/${find}/${replace}/g" $conffile
		log "sed -i \"s/${find}/${replace}/g\" $conffile"
		
		if [ $havem4 -eq 0 ]; then
			log "m4 $conffile > $outfile"
			m4 $conffile > $outfile
		else
			log "M4 was not detected, config will not be generated"
		fi
		
	elif [ -f $outfile ]; then	
		
		local find="^DS.*"
		local replace="DS${var_mailhost}.${var_dnsdomain}"
		sed -i $sed_suffix "s/${find}/${replace}/g" $outfile
		log "sed -i \"s/${find}/${replace}/g\" $outfile"
	else
		log "I cant find anything that resembles sendmail, is it installed?"
	fi
}


#=== FUNCTION =========================================================================
# NAME: bigfix_setup
# DESCRIPTION: Sets up the sytem for bigfix 
#======================================================================================

function bigfix_setup()
{
	log "Configuring bigfix"
	notice "Configuring System For Bigfix" 3
	
	mkdir -p /var/opt/BESClient/Intel/
	mkdir -p /etc/opt/BESClient/
	
	echo "12:34" > /var/opt/BESClient/bigfixtime.cache
	
	cp ${ilabdir}/AdminGroup.default /var/opt/BESClient/Intel/AdminGroup
	chown root:daemon /var/opt/BESClient/Intel/AdminGroup
	chmod 644 /var/opt/BESClient/Intel/AdminGroup
	sed -i $sed_suffix "s/SITE/${var_shortcode}/g" /var/opt/BESClient/Intel/AdminGroup
	
	cp ${ilabdir}/besclient.config.default /var/opt/BESClient/besclient.config.default
	chown root:daemon /var/opt/BESClient/besclient.config.default
	chmod 644 /var/opt/BESClient/besclient.config.default
	
	cp ${ilabdir}/actionsite.afxm /etc/opt/BESClient/actionsite.afxm
	chown root:root /etc/opt/BESClient/actionsite.afxm
	chmod 644 /etc/opt/BESClient/actionsite.afxm
	
}


#=== FUNCTION =========================================================================
# NAME: nodes_setup
# DESCRIPTION: Sets up the system for nodes registration 
#======================================================================================

function nodes_setup()
{
    if [ "${nodes_confirm}" -eq "1" ]; then

    	askdialog "iLab: Nodes Setup" "\nAdd this computer to nodes?\n" 7

	    # not in correct ou, force computer rename
    	if [ "$?" -eq "0" ]; then
	    	return 0
    	fi 
    fi
	
	# Bring up the network

    if [ "${var_networkup}" -eq "0" ]; then

        distro_ifup

        if [ "$?" -ne "0" ]; then
		    confirm "Error" "Nodes registration failed, unable to bring up network. Contact EC support"
            return 1
	    fi

        var_networkup=1
    fi
	
	log "Registering in nodes"
	notice "Configuring System For Nodes" 3
	local ssh_bin=`which ssh`
	local ssh_options="-q -i ${ssh_pubkey} -o \"PubkeyAuthentication=yes\" -o \"StrictHostKeyChecking=no\" -o \"ConnectTimeout=5\" -o \"BatchMode=yes\""
	local ssh_exec="${ssh_bin} ${ssh_options} ${ssh_user}@${var_nodeshost}.${var_dnsdomain} \"${var_hostname}\""
	
	log "${ssh_exec}"
	echo "#!/bin/sh" > ${ilabdir}/nodes.sh
	echo "${ssh_exec}" >> ${ilabdir}/nodes.sh
	chmod +x ${ilabdir}/nodes.sh
	bash ${ilabdir}/nodes.sh
	
	return 0
}


#=== FUNCTION =========================================================================
# NAME: ssh_setup
# DESCRIPTION: Removes old ssh host keys
#======================================================================================

function ssh_setup()
{
	log "Clearing ssh hostkeys"
	notice "Regenerating ssh hostkeys" 3
	
	log "rm -rvf /etc/ssh/ssh_host_* >> ${ilabdir}/ilablog 2>&1"
	rm -rvf /etc/ssh/ssh_host_* >> ${ilabdir}/ilablog 2>&1
	
	#debian key won't regenerate automatically
	if [ "${var_distro}" -eq "debian" ]; then
		log "SSH hostkeys regen: dpkg-reconfigure openssh-server"
		dpkg-reconfigure openssh-server >> ${ilabdir}/ilablog 2>&1
	fi
}


#=== FUNCTION =========================================================================
# NAME: cleanup
# DESCRIPTION: Cleans up any ilab create temp or configuration files 
#======================================================================================

function cleanup()
{
	log "Cleaning up"
	notice "Cleaning Temporary Setup Files" 3
	
	rm -rf ${ilabdir}/ilablog >/dev/null 2>&1
	log "rm -rvf ${ilabdir}/ilablog >/dev/null 2>&1"
	log "rm -rvf ${ilabdir}/install.sh >> ${ilabdir}/ilablog 2>&1"
	rm -rvf ${ilabdir}/install.sh >> ${ilabdir}/ilablog 2>&1
	log "rm -rvf /etc/opt/quest/vas/host.keytab >> ${ilabdir}/ilablog 2>&1"
	rm -rvf /etc/opt/quest/vas/host.keytab >> ${ilabdir}/ilablog 2>&1
	
}


#=== FUNCTION =========================================================================
# NAME: init_setup
# DESCRIPTION: The main loop of the script
#======================================================================================

function init_setup()
{
	cleanup
	distro_detection
	site_choice

	var_hostname=""
	var_nisdomain="${nisdomain[ $choice ]}"
	var_dnsdomain="${dnsdomain[ $choice ]}"
	var_addomain="${addomain[ $choice ]}"
	var_shortcode="${shortcode[ $choice ]}"
	var_fullname="${fullname[ $choice ]}"
	var_proxyhost="${proxyhost[ $choice ]}"
	var_proxyport="${proxyport[ $choice ]}"
	var_automaster="${automaster[ $choice ]}"
	var_nishost1="${nishost1[ $choice ]}"
	var_nishost2="${nishost2[ $choice ]}"
	var_mailhost="${mailhost[ $choice ]}"
	var_ntphost1="${ntphost1[ $choice ]}"
	var_ntphost2="${ntphost2[ $choice ]}"
	var_ntphost3="${ntphost3[ $choice ]}"
	var_nodeshost="${nodeshost[ $choice ]}"
	
	hostname_setup
	nisclient_setup
	autofs_setup
	mail_setup
	proxy_setup
	bigfix_setup
	
	vas_setup
	nodes_setup
    ssh_setup
	distro_reboot
}



#--------------------------------------------------------------------------------------
# Entry point
#--------------------------------------------------------------------------------------

# Include site config
######################
if [ -f sites.sh ]; then
    source sites.sh
elif [ -f ${ilabdir}/sites.sh ]; then
    source ${ilabdir}/sites.sh
else
    source ../sites.sh
fi

init_setup
