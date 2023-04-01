---
title: what-account-is-xp-cmdshell-running-as
date: '2023-04-01 19:37:58 +0000'
categories:
- what-account-is-xp-cmdshell-running-as
tags:
- what-account-is-xp-cmdshell-running-as
---


from SSMS run;

`EXEC xp_cmdshell 'osql -E -Q"select suser_sname()"'`