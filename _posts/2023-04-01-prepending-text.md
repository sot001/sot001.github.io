---
title: prepending-text
date: '2023-04-01 19:37:57 +0000'
categories:
- prepending-text
- vim
tags:
- prepending-text
- vim
---


This prepends the beginning of each line with "//":

`:%s!^!//!`

It follows then that this appends to the end of the line

`:%s!$!//!`