---
title: disable-gui-on-boot
date: '2023-04-01 19:37:55 +0000'
categories:
- disable-gui-on-boot
tags:
- disable-gui-on-boot
---


edit /etc/default/grub and change the following line;

` GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`

to

`GRUB_CMDLINE_LINUX_DEFAULT="text"`

then run

`sudo update-grub`

startx will start the gui