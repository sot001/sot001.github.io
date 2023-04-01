---
title: manipulating-strings
date: '2023-04-01 19:37:57 +0000'
categories:
- manipulating-strings
tags:
- manipulating-strings
---


## String Length

`${#string}`

## Substring Extraction

`${string:start position[:optional length]}`

eg

`for file in *.aac;`
`do`
` mv ${`[`file:0:${#file}-4`](file:0:$%7B#file%7D-4)`}.aac ${`[`file:0:${#file}-4`](file:0:$%7B#file%7D-4)`}.mp3`
`done`

### on command line, use tr

    find . -iname \*ilo\* -exec basename {} \;
    lon-hcesx24-ilo.cfg
    lon-hcesx29-ilo.cfg
    lon-hcesx12-ilo.cfg
    lon-hcesx19-ilo.cfg

    find . -iname \*ilo\* -exec basename {} \; | tr -d '.cfg'
    lon-hesx24-ilo
    lon-hesx29-ilo
    lon-hesx12-ilo
    lon-hesx19-ilo