---
title: passwordless-login
date: '2023-04-01 19:37:57 +0000'
categories:
- passwordless-login
tags:
- passwordless-login
---


[category: ssh](category:_ssh "wikilink") also called public/private key
authentication

generate the keys on your local workstation:

`ssh-keygen -t rsa -b 4096`

  - ensure you enter a password for your generated keys here

then copy them across to the server via ssh-copy-id:

`ssh-copy-id server`

If ssh-copy-id isn't available, copy the id_rsa.pub key contents into
\~/.ssh/authorized_keys on the destination server.