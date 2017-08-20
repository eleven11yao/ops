#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

show_dev() {
    echo '---------------------------Show-ovn-nbctl-------------------------------'
    ovn-nbctl show
    echo '---------------------------Show-ovn-sbctl-------------------------------'
    ovn-sbctl show
    echo '---------------------------Show-ovs-vsctl-------------------------------'
    ovs-vsctl show
    echo '---------------------------dump-netns-desc-------------------------'
    ip netns list
    echo '---------------------------dump-ports-desc-------------------------'
    ip address list
}

dump_flows() {
    echo '---------------------------ovn-sbctl lflow-list-------------------------'
    ovn-sbctl lflow-list
    for dev in  br-eth1 br-int 
    do
        for cmd in  show dump-ports-desc dump-flows
        do
            exe="ovs-ofctl $cmd $dev"
            echo "---------------------------$exe-------------------------------"
            $exe
        done
    done
}