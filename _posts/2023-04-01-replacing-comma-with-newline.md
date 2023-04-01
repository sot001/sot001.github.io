---
title: replacing-comma-with-newline
date: '2023-04-01 19:37:58 +0000'
categories:
- replacing-comma-with-newline
tags:
- replacing-comma-with-newline
---


use the '\\r' combo instead of '\\n'

`hostname,hostalias,hostaddress,hoststate`
`:%s/,/\r/g`

`hostname`
`hostalias`
`hostaddress`
`hoststate`

To go back the other way, use '\\n' instead of '\\r'..weird

`:%s/\n/,/g`