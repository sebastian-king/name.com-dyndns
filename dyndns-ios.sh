#!/bin/bash

# requires Core Utils & Network Commands by Saurik in Cydia

if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <super_domain> <sub_domain>";
        exit
fi

API_HOST="api.example.net";

SUPER_DOMAIN="${1}";
SUB_DOMAIN="${2}";

ip=`ifconfig en0 | egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | head -n 1`;

ttl=60; # 1 minute becuase Mobile Internet to WiFi change can be very quick

#if [ -z "$ip" ]; then # maybe this is obsolete due to the new internal handling of a null IP
#  ip="";
#  #ip=`wget http://${API_HOST}/api/ip.php -qO- --no-check-certificate | head -n 1`; // integrated into ip2host.php
#fi

wget "http://${API_HOST}/api/ip2host.php?sub_domain=${SUB_DOMAIN}&super_domain=${SUPER_DOMAIN}&ip=$ip&ttl=$ttl" -qO- --no-check-certificate && echo ""
