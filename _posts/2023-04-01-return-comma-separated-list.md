---
title: return-comma-separated-list
date: '2023-04-01 19:37:58 +0000'
categories:
- return-comma-separated-list
tags:
- return-comma-separated-list
---


usethe coalecse function in sql server

eg. get a list of those db's with recovery model full for use in
auto-backup function for trans logs

`DECLARE @commalist varchar(max)`


`SELECT`
`@commalist = coalesce(@commalist + ', ', '') + name`
`FROM`
`master..sysdatabases`
`WHERE DATABASEPROPERTYEX(name, 'Status') = 'ONLINE'`
`and  DATABASEPROPERTYEX(name, 'Recovery') = 'FULL'`

`select @commalist`