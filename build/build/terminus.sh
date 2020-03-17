#!/bin/bash
# Created on 2020-03-17T12:27:12+1100, using template:terminus.sh.tmpl and json:gearbox.json

test -f /etc/gearbox/bin/colors.sh && . /etc/gearbox/bin/colors.sh

c_ok "Started."

c_ok "Installing packages."
APKBIN="$(which apk)"
if [ "${APKBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/terminus.apks ]
	then
		APKS="$(cat /etc/gearbox/build/terminus.apks)"
		${APKBIN} update && ${APKBIN} add --no-cache ${APKS}; checkExit
	fi
fi

APTBIN="$(which apt-get)"
if [ "${APTBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/terminus.apt ]
	then
		DEBS="$(cat /etc/gearbox/build/terminus.apt)"
		${APTBIN} update && ${APTBIN} install ${DEBS}; checkExit
	fi
fi


if [ -f /etc/gearbox/build/terminus.env ]
then
	. /etc/gearbox/build/terminus.env
fi

if [ ! -d /usr/local/bin ]
then
	mkdir -p /usr/local/bin; checkExit
fi

mkdir /usr/local/terminus; checkExit
cd /usr/local/terminus; checkExit
composer require pantheon-systems/terminus:${GEARBOX_VERSION}; checkExit

if [ -f /usr/local/terminus/vendor/bin/terminus ]
then
	c_ok "Terminus installed OK."
	chmod a+x /usr/local/terminus/vendor/bin/terminus; checkExit
	ln -s /usr/local/terminus/vendor/bin/terminus /usr/local/bin
else
	c_err "Terminus installation FAILED."
fi

c_ok "Finished."
