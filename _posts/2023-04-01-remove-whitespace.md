---
title: remove-whitespace
date: '2023-04-01 19:37:58 +0000'
categories:
- remove-whitespace
tags:
- remove-whitespace
---


In a search, \\s finds whitespace (a space or a tab), and \\+ finds one
or more occurrences.

This removes whitespace from the end of the line

`:%s/\s\+$//`

This removes from the start of the line

`:%s/^\s\+//`