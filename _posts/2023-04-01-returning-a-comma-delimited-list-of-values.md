---
title: returning-a-comma-delimited-list-of-values
date: '2023-04-01 19:37:58 +0000'
categories:
- returning-a-comma-delimited-list-of-values
tags:
- returning-a-comma-delimited-list-of-values
---


use a function:

`CREATE FUNCTION [dbo].[fnAreas](`
`@candidate_id int`
`)`
`RETURNS varchar(max)`
`AS`

`BEGIN`

`-- returns a comma-delimited list of areas for a given candidate_id`
`DECLARE @Areas varchar(max) `
`  `

`SELECT @Areas = COALESCE(@Areas + ', ', '') + `
`   a.area`
`from`
`area AS a`
`INNER JOIN candidate_area AS ca       `
`ON a.area_id = ca.area_id`
`WHERE`
`ca.candidate_id = @candidate_id`


`RETURN @Areas`

`END`