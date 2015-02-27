#!/bin/sh
\curl -sSL https://raw.githubusercontent.com/trick77/ipset-blacklist/master/update-blacklist.sh > /etc/cron.daily/update-blacklist.sh
chmod +x /etc/cron.daily/update-blacklist.sh
\curl -sSL https://raw.githubusercontent.com/trick77/ipset-blacklist/master/blacklistInit >  /etc/network/if-pre-up.d/blacklistInit
chmod +x /etc/network/if-pre-up.d/blacklistInit
apt-get install -y ipset
ipset create blacklist hash:net
/etc/cron.daily/update-blacklist.sh
iptables -I INPUT -m set --match-set blacklist src -j DROP
iptables-save | tee /etc/iptables.rules
