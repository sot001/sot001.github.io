check the cluster status by looking at the WSREP status variable, as
show [MySQL cluster](MySQL_cluster "wikilink") here

#### entire cluster is down, how do I restart it

If you have time, pick the server that is most up to date and manually
nominate that as your primary. SSH in and then bootstrap it;

`service mysql bootstrap-pxc`

This tells it not to wait for other nodes before starting recovery. Once
its online and looking ok, SSH into the other nodes and then simply
start the mysql service up;

`service mysql start`

#### first node is up, can't bring additional nodes up

check the innobackup.backup.log file on the master node. its found in
the mysql data drive. mysqld logs on the remote nodes are a little
misleading, indicating files are missing etc.

Common things to look out for are;

  - Failure to connect (Access denied for user 'sstuser'@'localhost'
    (using password: YES)).
      - For this, ensure the password you have for sstuser in the my.cnf
        file is correct ON THE MASTER. remote nodes initiate a local
        connection on the master for state transfer