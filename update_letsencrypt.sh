#!/bin/bash

x=$(pgrep update_letsencrypt.sh | wc -w)
if [ $x -gt 2 ]; then
        exit
fi

APACHECONF=$1

export DISPLAY=:0.0
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin
HOME=/root

source $HOME/.bash_profile

if [ -d "${APACHECONF}ssl/letsencrypt" ]
then
	${APACHECONF}ssl/letsencrypt/letsencrypt-auto
fi


