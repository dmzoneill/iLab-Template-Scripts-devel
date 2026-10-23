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

source "$(dirname "${BASH_SOURCE[0]}")/sites_common.sh"

ilab_add_site "nis.igk.intel.com" \
	"igk.intel.com" \
	"GER" \
	"gklv" \
	"igk" \
	"Gdansk" \
	"autoproxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "none.de" \
	"imu.intel.com" \
	"GER" \
	"mulv" \
	"imu" \
	"Munich" \
	"autoproxy" \
	"911" \
	"$(printf "/nfs/imu /etc/auto.nfs.imu\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "iir.intel.com" \
	"ir.intel.com" \
	"GER" \
	"irlv" \
	"iir" \
	"Leixlip" \
	"proxy" \
	"911" \
	"$(printf "/nfs/iir/home yp:auto.nfs.iir.home sec=krb5\n/nfs yp:auto.nfs")" \
	"iir-nis-host1" \
	"iir-nis-host2" \
	"ecsmtp" \
	"iir-ntp-host1" \
	"iir-ntp-host2" \
	"iir-ntp-host1" \
	"iir-nodes-host"

ilab_add_site "isw.intel.com" \
	"isw.intel.com" \
	"GER" \
	"swlv" \
	"isw" \
	"Swindon" \
	"proxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "iul.intel.com" \
	"iul.intel.com" \
	"GER" \
	"ullv" \
	"iul" \
	"Ulm" \
	"autoproxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "ka.intel.com" \
	"ka.intel.com" \
	"GER" \
	"kalv" \
	"ka" \
	"Karlsruhe" \
	"proxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host1" \
	"nodes-host"

ilab_add_site "basiscomm.ie" \
	"ir.intel.com" \
	"GER" \
	"silv" \
	"sie" \
	"Shannon" \
	"proxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "basiscomm.ie" \
	"ir.intel.com" \
	"GER" \
	"wgclv" \
	"wgc" \
	"Welwyn Garden City" \
	"proxy" \
	"911" \
	"$(printf "+auto.masterwgcpub\n")" \
	"wgcvnis001" \
	"wgcvnis002" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "nc.intel.com" \
	"nc.intel.com" \
	"GER" \
	"nclv" \
	"nc" \
	"Sophia" \
	"autoproxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "IDC" \
	"iil.intel.com" \
	"GER" \
	"iilv" \
	"idc" \
	"Haifa" \
	"proxy" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"idc-nis" \
	"idc-nis" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"inis001"
