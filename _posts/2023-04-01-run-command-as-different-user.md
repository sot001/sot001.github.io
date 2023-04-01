---
title: run-command-as-different-user
date: '2023-04-01 19:37:58 +0000'
categories:
- run-command-as-different-user
tags:
- run-command-as-different-user
---


`su - `username` -s `shell` -c "`command`"`

eg;

`su - www-data -s /bin/bash -c "/usr/bin/youtube-downloader.sh"`

