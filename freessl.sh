#!/bin/bash

export DISPLAY=:0.0
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin
HOME=/root
APACHECONF="/etc/httpd/conf/"

source $HOME/.bash_profile

x=$(pgrep freessl.sh | wc -w)
if [ $x -gt 2 ]; then
        exit
fi

if [ ! -d "${APACHECONF}ssl" ]
then
	mkdir ${APACHECONF}ssl
fi

if [ ! -d "${APACHECONF}ssl/letsencrypt" ]
then
	./install_letsencrypt.sh ${APACHECONF}
fi

#TODO
# The domains below need to be in an array (possibly auto read from vhost files

HostName="demoserver.co.za"
Path="/home/demoserv/public_html"
Type="full"
EmailAddress="john@softsmart.co.za"

rm -fr /etc/letsencrypt/live/$HostName*
rm -fr /etc/letsencrypt/archive/$HostName*
rm -fr /etc/letsencrypt/renewal/$HostName*.conf

./freessl.exp "$HostName" "$Path" "$Type" "$EmailAddress"

