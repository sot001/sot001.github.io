---
title: removing-hidden-files
date: '2023-04-01 19:37:58 +0000'
categories:
- removing-hidden-files
tags:
- removing-hidden-files
---


find the inum of it via ls -il;

`root@server:/export/home/operator:> ls -il`
`total 217`
`    `**`176546`**` -rw-r--r--   1 root     root         205 Nov 22 09:22 `
`    234262 -rwxr--r--   1 root     root         242 Oct  6  2006 bkup_report`

check the inum

`root@server:/export/home/operator:> find . -inum 176546 -exec ls -al {} \;`
`-rw-r--r--   1 root     root         205 Nov 22 09:22 ./`

remove it

`root@server:/export/home/operator:> find . -inum 176546 -exec rm -i {} \;`
`rm: remove ./ (yes/no)? yes`