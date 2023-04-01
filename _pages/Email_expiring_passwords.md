`/****** Object:  StoredProcedure [dbo].[sp_EmailExpiringPasswords]    Script Date: 09/10/2012 09:16:38 ******/`
`SET ANSI_NULLS ON`
`GO`

`SET QUOTED_IDENTIFIER ON`
`GO`

`-- =============================================`
`-- Author:     K Sotiroff`
`-- Create date: 7/7/11`
`-- Description:    Send reminders of expiring passwords`
`-- =============================================`
`CREATE PROCEDURE [dbo].[sp_EmailExpiringPasswords] `

`AS`
`BEGIN`
`set nocount on `

`declare @msg varchar(max), @days int, @name varchar(50), @daysleft int`
`declare @expiring table (name varchar(255), [days] int)`

`set @days = 14`

`set @msg = 'The following accounts have less than ' +CAST(@days as varchar) + ' days until their password  expires.`

`'`
`insert @expiring`
`select sl.name, convert(int, LOGINPROPERTY(sl.name, 'DaysUntilExpiration'))`
`from master.sys.syslogins sl left join master.sys.sql_logins s_l on sl.sid = s_l.sid`
`where  LOGINPROPERTY(sl.name, 'DaysUntilExpiration') is not null`
`and LOGINPROPERTY(sl.name, 'DaysUntilExpiration') < @days`
`and  is_disabled <> 1 `
`and LOGINPROPERTY(sl.name, 'IsLocked') <> 1`
`order by LOGINPROPERTY(sl.name, 'DaysUntilExpiration') `

`while exists(select name from @expiring)`
`begin `
`   select top 1 @name = name, @daysleft = [days]`
`   from @expiring `
`   `
`   set @msg = @msg + '`
`' + @name + ' ' + convert(varchar(3), @daysleft ) + ' Days till expiry'`

`   delete @expiring where name = @name`

`end`


`exec [admin].[dbo].[sp_emaildba] 'Expiring passwords', @msg`
`END `

`GO`