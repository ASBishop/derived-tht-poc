#!/usr/bin/env bash
# Filename:                ironic_download.sh
# Description:             download inspection data from swift
# Supported Langauge(s):   GNU Bash 4.3.x
# Time-stamp:              <2017-01-26 08:43:09 jfulton> 
# -------------------------------------------------------
source ~/stackrc
export PASSWD=$(sudo crudini --get /etc/ironic-inspector/inspector.conf swift password)

uuids=$(openstack baremetal node list --format value -c UUID)

if [[ ! $# -eq 0 ]] ; then
    match=$1 # find ironic uuid matching $match
    for uuid in $uuids; do
	props=$(openstack baremetal node show $uuid --format value -c properties)
	match_count=$(echo $props | grep $match | wc -l)
	if [ $match_count -gt 0 ]; then
	    echo -n $uuid  # return this value to the python script
	    uuids=$uuid # shorten list for loop below (just download 1)
	    break
	fi
    done
    # if no match is found, $uuids is unchanged and all nodes will be downloaded
fi

if [ -d hardware ]; then
    rm -rf hardware # always download a new copy
fi

mkdir hardware
pushd hardware > /dev/null
for uuid in $uuids; do
    swift -q -U service:ironic -K $PASSWD download ironic-inspector inspector_data-$uuid 2> /dev/null
done
popd > /dev/null
