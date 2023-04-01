---
title: sed--remove-comments-and-blank-lines
date: '2023-04-01 19:37:58 +0000'
categories:
- sed--remove-comments-and-blank-lines
tags:
- sed--remove-comments-and-blank-lines
---


multiple -e command scan be combined on a single line

`sed -e 's/#.*$//' -e '/^\s*$/d' /etc/webalizer.conf`

`-e 's/#.*$//' <- this looks for the # character followed by any single character (.) and then (*) repeats the previous 'any single character' zero or more times, `
`catching comments with no characters afterwards as well`

`-e '/^\s*$/d' <- this looks for lines that have no characters from the start of the line (^) to the end of the line ($) and deletes (d) them.`

` -e '/^\#/d' <- this would have also removed any lines with comments on them, with the # at the start (^) of the line`