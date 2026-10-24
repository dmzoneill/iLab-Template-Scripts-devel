#!/bin/bash
#======================================================================================
# FILE: sites_common.sh
# USAGE: source sites_common.sh (sourced by the <region>_sites.sh files)
#
# DESCRIPTION: Shared helper for the region site config files. Appends one site to
#              the per-site settings arrays and advances var_sitecount.
#
# PROJECT: iLab Sysprep Scripts
#======================================================================================

var_sitecount=0

#=== FUNCTION =========================================================================
# NAME: ilab_add_site
# DESCRIPTION: Registers a site. Arguments, in order:
#              nisdomain dnsdomain addomain dnsprefix shortcode fullname proxyhost
#              proxyport automaster nishost1 nishost2 mailhost ntphost1 ntphost2
#              ntphost3 nodeshost
#              An empty argument leaves that setting unset for the site.
#======================================================================================

function ilab_add_site {
	local name
	var_sitecount=$((var_sitecount + 1))
	for name in nisdomain dnsdomain addomain dnsprefix shortcode fullname proxyhost \
		proxyport automaster nishost1 nishost2 mailhost ntphost1 ntphost2 ntphost3 nodeshost; do
		[ -z "$1" ] || printf -v "${name}[${var_sitecount}]" '%s' "$1"
		shift
	done
	return 0
}
