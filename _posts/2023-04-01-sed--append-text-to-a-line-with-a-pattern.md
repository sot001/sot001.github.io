---
title: sed--append-text-to-a-line-with-a-pattern
date: '2023-04-01 19:37:58 +0000'
categories:
- sed--append-text-to-a-line-with-a-pattern
tags:
- sed--append-text-to-a-line-with-a-pattern
---


The following will append ',doubletake_servers' to the end of a line
containing 'hostgroups'

`sed '/hostgroups/ s/$/ ,doubletake_servers/' filename.cfg`