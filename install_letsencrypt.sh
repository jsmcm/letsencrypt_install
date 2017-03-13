#!/bin/bash
APACHECONF=$1

x=$(pgrep install_letsencrypt.sh | wc -w)
if [ $x -gt 2 ]; then
        exit
fi

export DISPLAY=:0.0
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin
HOME=/root

source $HOME/.bash_profile

yum install epel-release -y

cd /tmp
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release-6*.rpm

yum install expect -y

if [ ! -d "${APACHECONF}ssl" ]
then
	mkdir ${APACHECONF}ssl
fi

cd ${APACHECONF}ssl
rm -fr ${APACHECONF}letsencrypt

git clone https://github.com/letsencrypt/letsencrypt

cd ${APACHECONF}ssl/letsencrypt
./letsencrypt-auto

sleep 1
