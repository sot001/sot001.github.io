---
title: memcached
date: '2023-04-01 19:37:57 +0000'
categories:
- memcached
tags:
- memcached
---


Running multi threaded memcached instances on dedicated hardware, with
config details stored in a database for central management.

Consists of helper script (memcached_multi), MySQL table (ports) and a
modification to the memcached init script;

#### Helper script

Place the helper script somewhere logical such as
/usr/local/bin/memcached_multi.pl

    #!/usr/bin/perl
    #
    # memcached_multi       Start memcahced instances
    #
    # 08 Sept 2014
    # Kristian Sotiroff
    #
    # chkconfig: - 80 12
    # description: init script for starting many memcache instances based on a database
    #
    #
    # set tabstop=4

    use strict;
    use warnings;
    use DBI();
    use Switch;
    use Data::Dumper;

    # configuration here
    my ($user, $pass, $db, $dbhost)  = ('dbuser', 'password', 'dbname', 'databasehostname');
    # cached local file of details
    my $staticfile = '/etc/sysconfig/memcached';
    my $pidfile = '/var/run/memcached.pids';
    my $server = `hostname -s`;

    # variables
    my $dsn = "DBI:mysql:host=$dbhost;database=$db";
    my ($op, $query, $sth, @row_array, $allports_array, $port_array, $extra_config);

    #
    # prep work
    #
    # get info from the database
    checkDatabase();

    sub checkDatabase {
        # connect to database
        my $dbh = DBI->connect($dsn, $user, $pass, {RaiseError => 0, PrintError => 0})
            or warn "Cannot connect to the database: $DBI::errstr\nFalling back to cached details\n";

        if ($dbh) {
            chomp($server);
            $query = "select port, memory, ext_config from vw_memcacheserver where hostname = '$server'";
            $allports_array = $dbh->selectall_arrayref($query, {Slice => {} })
                or warn "Cannot get memcache info using $query\n$DBI::errstr\n";
            $dbh->disconnect;
        }
        # now check we got somethening and write it out to the cache file
        if (!$allports_array) {
            die "The memcache array is empty, stopping here for safety's sake\n";
        }

        # write to the file
        writeCachefile();
    }

    sub  writeCachefile {
        open(CACHE, "> $staticfile")
            or die "Can't write to $staticfile\n";

        # loop over the data and write the commands out to a cache file to be run from later.
        foreach my $port_array ( @$allports_array ) {
            $extra_config = ($port_array->{ext_config})? $port_array->{ext_config}:'';
            print CACHE "/usr/bin/memcached -d -m $port_array->{memory} -u nobody -p $port_array->{port} $extra_config;\n";
        }
        close(CACHE);
        # change permissions
        chmod(0744, $staticfile);
    }

#### MySQL tables

    CREATE TABLE ports (
      id int(11) NOT NULL AUTO_INCREMENT,
      server varchar(50) NOT NULL,
      label varchar(50) NOT NULL,
      port int(11) NOT NULL,
      memory int(11) NOT NULL DEFAULT '1024',
      ext_config varchar(32) DEFAULT NULL,
      PRIMARY KEY (id),
      KEY server (server)
    )

    eg;
    +----+---------+-------+--------+---------------+
    I id I server  I port  I memory I ext_config    I
    +----+---------+-------+--------+---------------+
    I  1 I server1 I 11212 I   1024 I NULL          I
    I  2 I server1 I 11213 I   1024 I NULL          I
    I  3 I server1 I 11314 I   1024 I NULL          I
    I  4 I server1 I 11215 I   1024 I NULL          I
    I  5 I server1 I 11216 I   2048 I -c 2048 -I 2m I
    I  6 I server2 I 11212 I   1024 I NULL          I
    I  7 I server2 I 11213 I   1024 I NULL          I
    I  8 I server2 I 11314 I   1024 I NULL          I
    I  9 I server2 I 11215 I   1024 I NULL          I
    I  10I server2 I 11216 I   2048 I -c 2048 -I 2m I
    +----+---------+-------+--------+---------------+

#### Init script