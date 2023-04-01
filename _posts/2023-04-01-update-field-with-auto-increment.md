---
title: update-field-with-auto-increment
date: '2023-04-01 19:37:58 +0000'
categories:
- update-field-with-auto-increment
tags:
- update-field-with-auto-increment
---


given an existing table of assets, update the asset tag with a derived
value based on the internal row number to create values such as;

`LMCSOFTWARE001`
`LMCSOFTWARE029`
`LMCSOFTWARE030`
`LMCSOFTWARE032`

`;WITH newassetnum AS (`
`select  `
`   description,`
`   row_number() over (order by description) as newasset,`
`   [Asset #]`
`from [dbo].[rawasset] `
`where [Site/Location] like '%software%'`
`)`
`update newassetnum`
`set [Asset #] = 'LMCSOFTWARE' + RIGHT('000' + cast(newasset as varchar(3)),3)`