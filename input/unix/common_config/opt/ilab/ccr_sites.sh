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

source "$(dirname "${BASH_SOURCE[0]}")/sites_common.sh"

ilab_add_site "pds01" \
	"sh.intel.com" \
	"CCR" \
	"shilab" \
	"sh" \
	"Zihzu" \
	"proxy-prc" \
	"911" \
	"$(printf "+auto.masterpub\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "msk" \
	"ims.intel.com" \
	"CCR" \
	"mslv" \
	"ims" \
	"Moscow" \
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

ilab_add_site "inn" \
	"inn.intel.com" \
	"CCR" \
	"nnlv" \
	"inn" \
	"Nizhny Novgorod" \
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

ilab_add_site "nsk" \
	"ins.intel.com" \
	"CCR" \
	"nslv" \
	"ins" \
	"Novosibirsk" \
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

ilab_add_site "spb" \
	"pb.intel.com" \
	"CCR" \
	"pblv" \
	"pb" \
	"St. Petersburg" \
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
