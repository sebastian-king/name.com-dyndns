#!/bin/bash

if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <super_domain> <sub_domain>";
        exit
fi

API_HOST="api.example.net";

SUPER_DOMAIN="${1}";
SUB_DOMAIN="${2}";

ip=`ifconfig en0 | egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n 1`;
if [ -z "$ip" ]; then
  ip="172.20.10.2"; // my public ip, don't know where this comes from
fi
wget "http://${API_HOST}/api/ip2host.php?sub_domain=${SUB_DOMAIN}&super_domain=${SUPER_DOMAIN}&ip=$ip" -qO- && echo ""
