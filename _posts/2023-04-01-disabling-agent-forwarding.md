---
title: disabling-agent-forwarding
date: '2023-04-01 19:37:55 +0000'
categories:
- disabling-agent-forwarding
tags:
- disabling-agent-forwarding
---


To log in to another host without carrying all your keys acorss you can
do

`ssh -a host`

or to make it permanent, whack the following line in your .ssh/config
file

`ForwardAgent        no`