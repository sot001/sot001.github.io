---
title: firewalld
date: '2023-04-01 19:37:56 +0000'
categories:
- firewalld
tags:
- firewalld
---


[category:firewall](category:firewall "wikilink")
[category:security](category:security "wikilink")

### Is it running?

    [root@lnhcp018adm services]#  systemctl status firewalld
    firewalld.service - firewalld - dynamic firewall daemon
       Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled)
       Active: active (running) since Tue 2015-01-27 09:58:10 GMT; 6min ago
     Main PID: 2467 (firewalld)
       CGroup: /system.slice/firewalld.service
               \u2514\u25002467 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid

    Jan 27 09:58:10 lnhcp018adm systemd[1]: Started firewalld - dynamic firewall daemon.

or...

    [root@lnhcp018adm services]# firewall-cmd --state
    running

### what are we currently allowing?

    [root@lnhcp018adm services]# firewall-cmd --list-all
    work (default, active)
      interfaces: eno16777984
      sources:
      services: dhcpv6-client http https ipp-client ssh
      ports:
      masquerade: no
      forward-ports:
      icmp-blocks:
      rich rules:

Note: this only shows the permanent rules in the current zone (work in
this case) which is default and active. For more info on zones, check
[this](http://www.certdepot.net/rhel7-get-started-firewalld/) excellent
link.

### I want to add a port

    [root@lnhcp018adm services]# firewall-cmd --add-port=5666/tcp
    success

### I want the new port to stay after a reboot

    [root@lnhcp018adm services]# firewall-cmd --add-port=5666/tcp --permanent
    success

### I want a port locked to a specific IP

    firewall-cmd --permanent --zone=public --add-rich-rule='
      rule family="ipv4"
      source address="1.2.3.4/32"
      port protocol="tcp" port="4567" accept'

### Block a single IP

    firewall-cmd --zone="public" --add-rich-rule='rule family="ipv4" source address="1.2.3.4" reject
    firewall-cmd --permanent --zone="public" --add-rich-rule='rule family="ipv4" source address="1.2.3.4" reject'