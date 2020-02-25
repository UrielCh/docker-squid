#!/bin/sh
if [ -z $PASSWORD ]
then
 echo 'PASSWORD env variable is missing'
 exit
fi

if [ -z $PORT ]
then
 echo 'PORT env variable is missing'
 exit
fi

sed s/PORT/$PORT/ /etc/squid/squid.conf_ > /etc/squid/squid.conf
C=0;
rm -f /etc/squid/squid_users /etc/squid/users.conf
touch /etc/squid/squid_users
for IP in $(ip a | grep inet\  | grep brd | grep -v docker | grep -E -o 'inet [0-9.]+{8,}' | cut -d\  -f2)
do
 echo ADD IP $IP
 htpasswd -b /etc/squid/squid_users user$C $PASSWORD
 echo acl user_$C proxy_auth user$C >> /etc/squid/users.conf
 echo tcp_outgoing_address $IP user_$C >> /etc/squid/users.conf
 C=$((C+1))
done
if [ $C -eq 0 ]
then
 echo 'No network outgoint interface founed'
 exit
fi
squid -z -f /etc/squid/squid.conf
echo cache OK
sleep 1
squid -N -f /etc/squid/squid.conf
# cat /etc/squid/squid.conf
# find / | grep ncsa_auth