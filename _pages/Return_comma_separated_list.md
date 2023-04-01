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