#!/bin/bash
#======================================================================================
# FILE: deploy.sh
# USAGE: ./deploy.sh
#
# DESCRIPTION: Copies and installs required files to prepare a template for ilab.
#              You should run /opt/ilab/preparetemplate.sh after this script to
#              complete the ilabification process
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

LINE="===================================================================="

REGION=""
TEMPLATE=""
NODES="n"
BIGFIX="n"

BSD=`uname -o`
sed_suffix=""
BASH=`which bash`

if [ "${BSD}" = "FreeBSD" ]; then
    sed_suffix="\"\""
fi

#--------------------------------------------------------------------------------------
# Functions 
#--------------------------------------------------------------------------------------


#=== FUNCTION =========================================================================
# NAME: clean_deploy
# DESCRIPTION: cleans and previous deployment run
#======================================================================================

function clean_deploy
{
    rm -rf ${ilabdir} > /dev/null
    mkdir -p ${ilabdir}
    cp -v common.sh ${ilabdir}
}


#=== FUNCTION =========================================================================
# NAME: install_system_messages
# DESCRIPTION: Installs legal notices / message of the day
#======================================================================================

function install_system_messages
{
    cp -v common_config/opt/ilab/issue /etc
    cp -v common_config/opt/ilab/motd /etc
}


#=== FUNCTION =========================================================================
# NAME: install_ssh_pubkeys
# DESCRIPTION: Copies the root pub keys in place
#======================================================================================

function install_ssh_pubkeys
{
    mkdir -vp /root/.ssh
    chmod -v 700 /root/.ssh
    cp -v common_config/opt/ilab/dot.ssh/authorized_keys /root/.ssh
    chmod -v 600 /root/.ssh/authorized_keys
}


#=== FUNCTION =========================================================================
# NAME: install_bigfix 
# DESCRIPTION: Copies the bigfix config in place, also installs the client.
#======================================================================================

function install_bigfix
{
    if [ "$BIGFIX" = "n" ]; then
        sed -i $sed_suffix 's/bigfix_setup$/\#bigfix_setup/g' ${ilabdir}/common.sh
    else
        cp -v common_config/opt/ilab/AdminGroup.default ${ilabdir}
        cp -v common_config/opt/ilab/actionsite.afxm ${ilabdir}
        cp -v common_config/opt/ilab/besclient.config.default ${ilabdir}
    fi
}


#=== FUNCTION =========================================================================
# NAME: install_nodes                                                                        
# DESCRIPTION: Simply enables or disables the nodes registration in the common.sh
#              This may be expanded later to include ucat
#======================================================================================

function install_nodes
{
    if [ "$NODES" = "n" ]; then
        sed -i $sed_suffix 's/nodes_setup$/\#nodes_setup/g' ${ilabdir}/common.sh
    else
        cp -v common_config/opt/ilab/ecilab ${ilabdir}
    fi
}


#=== FUNCTION =========================================================================
# NAME: deploy_template_files                                                                        
# DESCRIPTION: Copies the distibution specific files in place and sets the distro
#              Shebangs and also fixes permisisons for execution later.
#======================================================================================

function deploy_template_files
{
    cp -v ${TEMPLATE}/preparetemplate.sh ${ilabdir}
    cp -v ${TEMPLATE}/sethostname.sh ${ilabdir}
    cp -v common_config/opt/ilab/${REGION}_sites.sh ${ilabdir}/sites.sh

    chmod 600 ${ilabdir}/*
    chmod 700 ${ilabdir}/sethostname.sh
    chmod 700 ${ilabdir}/preparetemplate.sh

    sed -i $sed_suffix "1s:^#!\/bin\/bash:#!$BASH:" ${ilabdir}/common.sh
    sed -i $sed_suffix "1s:^#!\/bin\/bash:#!$BASH:" ${ilabdir}/sethostname.sh
    sed -i $sed_suffix "1s:^#!\/bin\/bash:#!$BASH:" ${ilabdir}/preparetemplate.sh
    sed -i $sed_suffix "1s:^#!\/bin\/bash:#!$BASH:" ${ilabdir}/sites.sh
}

#=== FUNCTION =========================================================================
# NAME: check_dialog
# DESCRIPTION: Checks for 'dialog' package installation
# RETURN: 1/0
#======================================================================================

function check_dialog
{
    if which dialog &> /dev/null; then
        return 0
    else
        return 1
	fi
}

#=== FUNCTION =========================================================================
# NAME: deploy                                                                        
# DESCRIPTION: Deploy is the main loop, it executes all the other functions.
#              It determines firstly whether the user input requested template exists
#              Al then proceeds to deploy that template.
#======================================================================================

function deploy
{
	if check_dialog; then
    	echo "dialog installed, looking for ${REGION}"
        else
            echo "dialog package not found, unable to continue..."
            echo "please install dialog and restart deployment"
            exit
    fi

    if [ -d "${TEMPLATE}" ]; then
        if [ -e "common_config/opt/ilab/${REGION}_sites.sh" ]; then
            echo "Readying template..."
            clean_deploy
            install_nodes
            install_bigfix
            install_system_messages
            install_ssh_pubkeys
            deploy_template_files
            
            echo ""
            echo $LINE
            echo "    If everything looks good you should now run /opt/ilab/preparetemplate.sh "
            echo ""
        else
            echo "Invalid region, please input [ger, gar, amr, ccr]"
            exit
	    fi
    else
        echo "Invalid template directory, please choose from the following"
        ls -d */ | grep -v common
        exit
    fi
}


#=== FUNCTION =========================================================================
# NAME: init_deploy                                                                        
# DESCRIPTION: Asks for basic information in order to deploy the ilab template files
#              and executes the deploy function 
#======================================================================================

function init_deploy
{
    echo $LINE
    echo "                iLab Template Readiness Script                      "
    echo $LINE
    echo ""

    read -p "Plese enter region [ger, gar, amr, ccr]: " REGION
    read -p "Please enter the template you want to use eg. [redhat, fedora, ubuntu, suse]: " TEMPLATE
    # read -p "Will this template require nodes registration? [y/n]: " NODES
    # read -p "Will this template require bigfix? [y/n]: " BIGFIX
    
    echo ""
    echo $LINE
    echo ""
    
    echo "looking for dialog"
    echo ""

    deploy
}


init_deploy
