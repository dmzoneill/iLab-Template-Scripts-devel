#!/bin/bash
#======================================================================================
# FILE: ger_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file contatining GER region site specific system config 
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

nisdomain[ $var_sitecount ]="nis.igk.intel.com"
dnsdomain[ $var_sitecount ]="igk.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="gklv"
shortcode[ $var_sitecount ]="igk"
fullname[ $var_sitecount ]="Gdansk"
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

nisdomain[ $var_sitecount ]="none.de"
dnsdomain[ $var_sitecount ]="imu.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="mulv"
shortcode[ $var_sitecount ]="imu"
fullname[ $var_sitecount ]="Munich"
proxyhost[ $var_sitecount ]="autoproxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "/nfs/imu /etc/auto.nfs.imu\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="iir.intel.com"
dnsdomain[ $var_sitecount ]="ir.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="irlv"
shortcode[ $var_sitecount ]="iir"
fullname[ $var_sitecount ]="Leixlip"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "/nfs/iir/home yp:auto.nfs.iir.home sec=krb5\n/nfs yp:auto.nfs")
nishost1[ $var_sitecount ]="iir-nis-host1"
nishost2[ $var_sitecount ]="iir-nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="iir-ntp-host1"
ntphost2[ $var_sitecount ]="iir-ntp-host2"
ntphost3[ $var_sitecount ]="iir-ntp-host1"
nodeshost[ $var_sitecount ]="iir-nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="isw.intel.com"
dnsdomain[ $var_sitecount ]="isw.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="swlv"
shortcode[ $var_sitecount ]="isw"
fullname[ $var_sitecount ]="Swindon"
proxyhost[ $var_sitecount ]="proxy"
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

nisdomain[ $var_sitecount ]="iul.intel.com"
dnsdomain[ $var_sitecount ]="iul.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="ullv"
shortcode[ $var_sitecount ]="iul"
fullname[ $var_sitecount ]="Ulm"
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

nisdomain[ $var_sitecount ]="ka.intel.com"
dnsdomain[ $var_sitecount ]="ka.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="kalv"
shortcode[ $var_sitecount ]="ka"
fullname[ $var_sitecount ]="Karlsruhe"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="nis-host1"
nishost2[ $var_sitecount ]="nis-host2"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host1"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="basiscomm.ie"
dnsdomain[ $var_sitecount ]="ir.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="silv"
shortcode[ $var_sitecount ]="sie"
fullname[ $var_sitecount ]="Shannon"
proxyhost[ $var_sitecount ]="proxy"
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

nisdomain[ $var_sitecount ]="basiscomm.ie"
dnsdomain[ $var_sitecount ]="ir.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="wgclv"
shortcode[ $var_sitecount ]="wgc"
fullname[ $var_sitecount ]="Welwyn Garden City"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterwgcpub\n")
nishost1[ $var_sitecount ]="wgcvnis001"
nishost2[ $var_sitecount ]="wgcvnis002"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="nodes-host"

var_sitecount=$(( var_sitecount + 1 ))

nisdomain[ $var_sitecount ]="nc.intel.com"
dnsdomain[ $var_sitecount ]="nc.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="nclv"
shortcode[ $var_sitecount ]="nc"
fullname[ $var_sitecount ]="Sophia"
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

nisdomain[ $var_sitecount ]="IDC"
dnsdomain[ $var_sitecount ]="iil.intel.com"
addomain[ $var_sitecount ]="GER"
dnsprefix[ $var_sitecount ]="iilv"
shortcode[ $var_sitecount ]="idc"
fullname[ $var_sitecount ]="Haifa"
proxyhost[ $var_sitecount ]="proxy"
proxyport[ $var_sitecount ]="911"
automaster[ $var_sitecount ]=$(printf "+auto.masterpub\n")
nishost1[ $var_sitecount ]="idc-nis"
nishost2[ $var_sitecount ]="idc-nis"
mailhost[ $var_sitecount ]="ecsmtp"
ntphost1[ $var_sitecount ]="ntp-host1"
ntphost2[ $var_sitecount ]="ntp-host2"
ntphost3[ $var_sitecount ]="ntp-host3"
nodeshost[ $var_sitecount ]="inis001"
