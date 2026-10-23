#!/bin/bash
#======================================================================================
# FILE: amr_sites.sh
# USAGE: source sites.sh
#
# DESCRIPTION: Include file containing AMR region site specific system config
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

ilab_add_site "an" \
	"an.intel.com" \
	"AMR" \
	"anlv" \
	"an" \
	"Austin" \
	"proxy" \
	"911" \
	"$(printf "+auto.master\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "chandler" \
	"ch.intel.com" \
	"AMR" \
	"chlv" \
	"ch" \
	"Chandler" \
	"proxy" \
	"911" \
	"$(printf "/nfs /etc/automap.d/auto..nfs\n+auto.master.linux\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "fmdln3" \
	"fm.intel.com" \
	"AMR" \
	"fmlv" \
	"fm" \
	"Folsom" \
	"proxy" \
	"911" \
	"$(printf "+auto.master.linux\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "ecrr" \
	"rr.intel.com" \
	"AMR" \
	"rrlv" \
	"rr" \
	"Rio Rancho" \
	"proxy" \
	"911" \
	"$(printf "+auto.master.linux\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "sc" \
	"sc.intel.com" \
	"AMR" \
	"sclv" \
	"sc" \
	"Santa Clara" \
	"proxy" \
	"911" \
	"$(printf "+auto.master.linux\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "jf.intel.com" \
	"jf.intel.com" \
	"AMR" \
	"orlv" \
	"or" \
	"Oregon" \
	"proxy" \
	"911" \
	"$(printf "+auto.master.linux\n")" \
	"nis-host1" \
	"nis-host2" \
	"ecsmtp" \
	"ntp-host1" \
	"ntp-host2" \
	"ntp-host3" \
	"nodes-host"

ilab_add_site "zpn.intel.com" \
	"zpn.intel.com" \
	"AMR" \
	"zpnly" \
	"zpn" \
	"Zapopan" \
	"proxy" \
	"911" \
	"$(printf "/home yp:auto.home sec=krb5\n/home yp:auto.home\n")" \
	"gmslinfr01" \
	"" \
	"ecsmtp" \
	"zpn31a-ccr01" \
	"zpn21b-ccr01" \
	"" \
	"gmslinfr01"
