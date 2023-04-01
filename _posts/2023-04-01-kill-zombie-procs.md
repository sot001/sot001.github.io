---
title: kill-zombie-procs
date: '2023-04-01 19:37:56 +0000'
categories:
- kill-zombie-procs
tags:
- kill-zombie-procs
---


(ref: [How to kill zombie
process](http://stackoverflow.com/questions/16944886/how-to-kill-zombie-process)

You can clean up a zombie process by killing its parent process with the
following command:

`kill -HUP $(ps -A -ostat,ppid | grep -e '[zZ]'| awk '{ print $2 }')`