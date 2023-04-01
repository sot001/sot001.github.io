---
title: mysql-replication-with-innobackupex
date: '2023-04-01 19:37:57 +0000'
categories:
- mysql-replication-with-innobackupex
tags:
- mysql-replication-with-innobackupex
---


If the master server is running innobackupex, then get the prepared
backup directory (must be prepared) and copy it across to the slave. The
do this;

Stop the slave;

`service mysql stop`

Move the old data dir out of the way;

    cd /mysql/data/
    mv data data.bak

Unzip the tarball

`tar xvfz mysql.20150506.tar.gz`

find the data files then move the parent directory to the data directory
and ensure the permissions are ok;

    mv /mysql/data/mysql_backup/innobackupex/20150506 /mysql/data
    chown -R mysql:mysql /mysql/data

Check the innodb log files are in the right place (check my.cnf file)
and then start mysql up if all is ok

`service mysql start`

Get the log position from the xtrabackup_binlog_info file in the data
dir

`cat /var/lib/mysql/xtrabackup_binlog_info`
`log-bin.000001     481`

Log in to mysql and connect it up to the master using the change master
command;

```
 mysql> CHANGE MASTER TO
                MASTER_HOST='$masterip',
                MASTER_USER='repl',
                MASTER_PASSWORD='$slavepass',
                MASTER_LOG_FILE='log-bin.000001',
                MASTER_LOG_POS=481;
```