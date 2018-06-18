#!/bin/bash
set -e

testAlias+=(
	[marcodangelo/AzureOpenVpn]='openvpn'
)

imageTests+=(
	[openvpn]='
	paranoid
        conf_options
        client
        basic
        dual-proto
        otp
	iptables
	revocation
	'
)
