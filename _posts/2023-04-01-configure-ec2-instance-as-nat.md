---
title: configure-ec2-instance-as-nat
date: '2023-04-01 19:37:55 +0000'
categories:
- configure-ec2-instance-as-nat
tags:
- configure-ec2-instance-as-nat
---


run this script;

    #!/bin/sh
    echo 1 > /proc/sys/net/ipv4/ip_forward
    echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
    /sbin/iptables -t nat -A POSTROUTING -o eth0 -s 0.0.0.0/0 -j MASQUERADE
    /sbin/iptables-save > /etc/sysconfig/iptables
    mkdir -p /etc/sysctl.d/
    cat <<EOF > /etc/sysctl.d/nat.conf
    net.ipv4.ip_forward = 1
    net.ipv4.conf.eth0.send_redirects = 0
    EOF

    echo "now add the route into the route table, Destination 0.0.0.0/0 Target (this instance) and also disable Source/Dest check on that(this) same instance"