#!/bin/sh
# filename:     install.sh
# author:       Nivigor
# date:         2026-02-22
# purpose:      Install RustDesk Server

DIR=$(dirname $(realpath $0))
if [ ! -d /usr/local/etc/rc.d ]; then mkdir -p /usr/local/etc/rc.d; fi
sed "s^%hbbdir%^${DIR}^" ${DIR}/hbbr.tmpl > /usr/local/etc/rc.d/hbbr
sed "s^%hbbdir%^${DIR}^" ${DIR}/hbbs.tmpl > /usr/local/etc/rc.d/hbbs
chmod +x /usr/local/etc/rc.d/hbbr /usr/local/etc/rc.d/hbbs

if [ ! -d /usr/local/etc/newsyslog.conf.d ]; then mkdir -p /usr/local/etc/newsyslog.conf.d; fi
sed "s^%hbbdir%^${DIR}^" ${DIR}/rustdesk.conf.tmpl > /usr/local/etc/newsyslog.conf.d/rustdesk.conf

sysrc hbbr_enable="YES"
sysrc hbbs_enable="YES"
service hbbr start
service hbbs start
