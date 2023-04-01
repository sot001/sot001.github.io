### mythtv-backend

  - also needs mythweb
  - old backups restored via mythrestore and hostname changed vie
    instructions
    [here](https://www.mythtv.org/wiki/Database_Backup_and_Restore)

### nginx

  - nightmare getting backuppc to work with nginx.. still not ideal.
  - found some good tips for mythweb, will post the config file for
    reference.

### backuppc

  - permissions issues. check
    [here](http://tristram.squarespace.com/home/2012/3/11/moving-the-backuppc-data-directory-to-an-external-hard-disk.html)
    for help
  - generate backuppc keys, then transfer to root@local and remote host.
    You may need to edit the sshd_config file and comment out
    'PermitRooLogin with-password' and bounce ssh the first time, or you
    will get permission denied when trying to ssh-copy-id

### mariadb-server

### e2guardian

  - is this the best place for this?