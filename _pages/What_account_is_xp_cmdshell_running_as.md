from SSMS run;

`EXEC xp_cmdshell 'osql -E -Q"select suser_sname()"'`