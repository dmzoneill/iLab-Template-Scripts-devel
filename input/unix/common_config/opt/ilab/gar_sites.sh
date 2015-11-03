#!/bin/bash
#======================================================================================
# FILE: gar_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file contatining GAR region site specific system config
#
# AUTHOR: "O Neill, David M" <david.m.oneill@intel.com>
# AUTHOR: "Redlarski, Michal" <michal.redlarski@intel.com>
# COMPANY: Intel - Engineering Computing
# PROJECT: iLab Sysprep Scripts
#======================================================================================

#--------------------------------------------------------------------------------------
# Sites Settings
#--------------------------------------------------------------------------------------

var_sitecount=1

nisdomain[ $var_sitecount ]="iind.intel.com"
dnsdomain[ $var_sitecount ]="iind.intel.com"
addomain[ $var_sitecount ]="GAR"
dnsprefix[ $var_sitecount ]="balv"
shortcode[ $var_sitecount ]="ba"
fullname[ $var_sitecount ]="Bangalore"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"
