---
title: set-sticky-bit
date: '2023-04-01 19:37:58 +0000'
categories:
- set-sticky-bit
tags:
- set-sticky-bit
---


`chmod +t test/`

shows as t in last bit

`ls -ld test`
`drwxrwxr-t 2 user user 4096 Oct 21 14:11 test`

This next bit isn't actually the sticky bit, but rather is setuid or
gid.

Use this to force all files under a directory to inherit the parent
permissions;

eg;

`chmod g+s /var/www/html`

this changes

`drw-r-----  1 root apache  /var/www/html`

to

`drw-r-s---  1 root apache  /var/www/html`

now any files under /var/www/html will be in the group apache