#!/bin/bash
#======================================================================================
# FILE: amr_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file contatining AMR region site specific system config
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

nisdomain[ $var_sitecount ]="an"
dnsdomain[ $var_sitecount ]="an.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="anlv"
shortcode[ $var_sitecount ]="an"
fullname[ $var_sitecount ]="Austin"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="chandler"
dnsdomain[ $var_sitecount ]="ch.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="chlv"
shortcode[ $var_sitecount ]="ch"
fullname[ $var_sitecount ]="Chandler"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "/nfs /etc/automap.d/auto..nfs\n+auto.master.linux\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="fmdln3"
dnsdomain[ $var_sitecount ]="fm.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="fmlv"
shortcode[ $var_sitecount ]="fm"
fullname[ $var_sitecount ]="Folsom"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master.linux\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="ecrr"
dnsdomain[ $var_sitecount ]="rr.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="rrlv"
shortcode[ $var_sitecount ]="rr"
fullname[ $var_sitecount ]="Rio Rancho"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master.linux\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="sc"
dnsdomain[ $var_sitecount ]="sc.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="sclv"
shortcode[ $var_sitecount ]="sc"
fullname[ $var_sitecount ]="Santa Clara"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master.linux\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="jf.intel.com"
dnsdomain[ $var_sitecount ]="jf.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="orlv"
shortcode[ $var_sitecount ]="or"
fullname[ $var_sitecount ]="Oregon"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.master.linux\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="zpn.intel.com"
dnsdomain[ $var_sitecount ]="zpn.intel.com"
addomain[ $var_sitecount ]="AMR"
dnsprefix[ $var_sitecount ]="zpnly"
shortcode[ $var_sitecount ]="zpn"
fullname[ $var_sitecount ]="Zapopan"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "/home yp:auto.home sec=krb5\n/home yp:auto.home\n")
nishost1[ $var_sitecount ]="gmslinfr01"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="zpn31a-ccr01"
ntphost2[ $var_sitecount ]="zpn21b-ccr01"
nodeshost[ $var_sitecount ]="gmslinfr01"