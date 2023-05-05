---
title: reset git credentials
date: '2023-05-05 12:53:56 +0100'
categories:
- git
- github
tags:
- git
- github
---
If your stored token has expired, reset it this way
```console
echo url=https://<github username>@github.com | git credential reject
```
next pull or push, it'll prompt for the new one