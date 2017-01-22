#!/bin/sh

##change vnc password
echo "change vnc password!"
echo "$VNC_PW\n$VNC_PW\n\n" | vncpasswd -f > /root/.vnc/passwd
chmod 0600 /root/.vnc/passwd
##start vncserver
echo "remove old vnc locks to be a reattachable container"
rm -rfv /tmp/.X*
chkconfig vncserver on
service vncserver start && tail -F /root/.vnc/*.log
