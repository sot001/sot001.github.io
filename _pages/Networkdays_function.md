Similar to excel function;

`create function dbo.fn_networkdays`
`(`
`@Startdate date`
`, @Enddate date`
`, @BankHol int = 0`
`)`
`RETURNS INT`
`AS`
`BEGIN`
`   declare  @days int = 0`

`   while @enddate >= @startdate`
`   begin`

`       if datename(dw,@enddate) not in ('Saturday','Sunday')`
`           set @days = @days + 1`

`       set @enddate = dateadd(d, -1, @enddate)`

`   end`

`   RETURN @days - @BankHol`
`END`

running the test over Easter period (2 holidays, plus sat / sun), it
gives;

`select dbo.fn_networkdays('2013-03-28', '2013-04-03', 2)`

`3`