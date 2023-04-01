---
title: run-script-as-different-user
date: '2023-04-01 19:37:58 +0000'
categories:
- run-script-as-different-user
tags:
- run-script-as-different-user
---


[category:security](category:security "wikilink")

To run as a different user that may not have a login shell use;

`su -c SCRIPT -s /bin/sh USER`

eg;

`su -c /home/nginx/html/youtube/youtube_downloader.sh -s /bin/bash www-data`

[Category:Linux](Category:Linux "wikilink")