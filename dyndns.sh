#!/bin/bash

if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <super_domain> <sub_domain>";
        exit
fi

SUPER_DOMAIN="${1}";
SUB_DOMAIN="${2}";

ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`;
wget "http://api.massivesoft.net/api/ip2host.php?sub_domain=${SUB_DOMAIN}&super_domain=${SUPER_DOMAIN}&ip=$ip" -qO- && echo ""
