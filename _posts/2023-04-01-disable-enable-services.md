---
title: disable-enable-services
date: '2023-04-01 19:37:55 +0000'
categories:
- disable-enable-services
tags:
- disable-enable-services
---


use update-rc.d to change runleevels, in a similar way to chkconfig on
centos

eg;

`sudo update-rc.d nxserver disable`

this removes all symlinks from /etc/rc2.d/S\* and renames them to
/etc/rc2.d/K\* which means they used to be **S**tart to **K**ill

do the same with 'enable' to reenable them. or use the 'defaults' option