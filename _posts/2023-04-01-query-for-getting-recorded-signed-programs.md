---
title: query-for-getting-recorded-signed-programs
date: '2023-04-01 19:37:57 +0000'
categories:
- query-for-getting-recorded-signed-programs
tags:
- query-for-getting-recorded-signed-programs
---


`create view vw_signedprograms as  `
`select r.* `
`from program p `
`inner join recorded r `
` on p.starttime = r.progstart `
` and p.title = r.title `
` and p.subtitle = r.subtitle `
` and p.subtitletypes like '%SIGNED%';`

then

`mysql> select * from vw_signedprograms;`