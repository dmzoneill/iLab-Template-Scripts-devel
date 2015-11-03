#!/bin/bash
#======================================================================================
# FILE: ccr_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file contatining CCR region site specific system config
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

nisdomain[ $var_sitecount ]="pds01"
dnsdomain[ $var_sitecount ]="sh.intel.com"
addomain[ $var_sitecount ]="CCR"
dnsprefix[ $var_sitecount ]="shilab"
shortcode[ $var_sitecount ]="sh"
fullname[ $var_sitecount ]="Zihzu"
proxyhost[ $var_sitecount ]="proxy-prc"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="msk"
dnsdomain[ $var_sitecount ]="ims.intel.com"
addomain[ $var_sitecount ]="CCR"
dnsprefix[ $var_sitecount ]="mslv"
shortcode[ $var_sitecount ]="ims"
fullname[ $var_sitecount ]="Moscow"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="inn"
dnsdomain[ $var_sitecount ]="inn.intel.com"
addomain[ $var_sitecount ]="CCR"
dnsprefix[ $var_sitecount ]="nnlv"
shortcode[ $var_sitecount ]="inn"
fullname[ $var_sitecount ]="Nizhny Novgorod"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="nsk"
dnsdomain[ $var_sitecount ]="ins.intel.com"
addomain[ $var_sitecount ]="CCR"
dnsprefix[ $var_sitecount ]="nslv"
shortcode[ $var_sitecount ]="ins"
fullname[ $var_sitecount ]="Novosibirsk"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="spb"
dnsdomain[ $var_sitecount ]="pb.intel.com"
addomain[ $var_sitecount ]="CCR"
dnsprefix[ $var_sitecount ]="pblv"
shortcode[ $var_sitecount ]="pb"
fullname[ $var_sitecount ]="St. Petersburg"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"