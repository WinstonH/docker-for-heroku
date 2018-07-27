#!/bin/bash
#start net speeder
ETH=$(eval "ifconfig | grep 'eth0'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
    nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
fi

# export the $PORT env
sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json
sed -i "s/PORT/$PORT/g" /etc/nginx/conf.d/default.conf
/usr/bin/supervisord -c /etc/supervisord.conf
