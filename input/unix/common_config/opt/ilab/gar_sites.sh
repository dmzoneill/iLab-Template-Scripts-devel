#!/bin/bash
#======================================================================================
# FILE: gar_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file containing GAR region site specific system config
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

ilab_add_site "iind.intel.com" \
	"iind.intel.com" \
	"GAR" \
	"balv" \
	"ba" \
	"Bangalore" \
	"autoproxy" \
	"911" \
	"$(printf "+auto.master\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"
