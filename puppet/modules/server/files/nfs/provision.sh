#!/bin/bash

VUID=`cat /etc/passwd | grep vagrant | cut -d: -f3`
VGID=`cat /etc/passwd | grep vagrant | cut -d: -f4`
NFSUID=`stat /source/ -c %u`

if [ "$VUID" != "$NFSUID" ]
then
    echo "Changing vagrant user ID to match NFS user ID"

    replace "vagrant:x:${VUID}:${VGID}::" "vagrant:x:${NFSUID}:${VGID}::" -- /etc/passwd

    chown -R vagrant:vagrant /home/vagrant

    /etc/init.d/httpd stop

    sleep 5

    /etc/init.d/httpd start
fi