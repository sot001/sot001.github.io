Binary logs on the master are used to transfer updates to the slave, so
removing them all will break replication. Removing them at the
filesystem is not ideal as you will break the internal indexing that
mysql keeps, so it knows which logs it has.

the best way to clear logs down is;

  - check how many log files are on the system;

`mysql> show binary logs;`
`+---------------+------------+`
`| Log_name      | File_size  |`
`+---------------+------------+`
`| binlog.000001 | 1073745110 |`
`| binlog.000002 | 1073809202 |`
`| binlog.000003 | 1074622047 |`
`| binlog.000004 | 1074131675 |`
`| binlog.000005 | 1073890119 |`
`| binlog.000006 | 1074065745 |`
`| binlog.000007 | 1073742082 |`
`| binlog.000008 | 1073742411 |`
`| binlog.000009 |  190740717 |`
`+---------------+------------+`

  - check the expire_logs_days variable. this variable sets the
    retention period of the logs in days and removes them automatically
    once they are older than this value. a value of 0 means 'no expiry'.

`mysql> show variables like '%expire%';`
`+------------------+-------+`
`| Variable_name    | Value |`
`+------------------+-------+`
`| expire_logs_days | 0     |`
`+------------------+-------+`

set the value by running the following command (2 days ;

`mysql> set global expire_logs_days=2;`
`mysql> show variables like '%expire%';`
`+------------------+-------+`
`| Variable_name    | Value |`
`+------------------+-------+`
`| expire_logs_days | 2     |`
`+------------------+-------+`

  - to remove extra logs immediately, execute the following from within
    mysql after ensuring the slaves are up to date and are not lagging
    behind;

`mysql> purge binary logs before '2012-10-27 00:00:00';`

  - when the log drive has completely filled, the above won't work so
    then manually edit the binlog.index and remove any files you don't
    want from the list and then delete them physically from the drive,
    bearing in mind that any replication we have going will need to read
    the files from the point it broke, so don't remove them all. remove
    them to a point that mysql starts working again and let replication
    catch up. once it has, then you can purge them as much as required.