---
title: aws-rds-connect-script
date: '2023-04-01 19:37:55 +0000'
categories:
- aws-rds-connect-script
tags:
- aws-rds-connect-script
---


[category: rds](category:_rds "wikilink") [category:
aws](category:_aws "wikilink")

Connect to different instances of RDS via ssh tunnels (ie bastion) with
the handy (redacted) script show at the bottom of the page whcih
effectively opens an ssh tunnel from here to RDS via the bastion.

requires;

  - ssh access to a bastion server
  - connectivity from the bastion server to the RDS instance
  - mysql_config script configured with the hosts set up like this;

<!-- end list -->

    $ mysql_config_editor print --all

    [client]
    password = *****
    [mysql1-euw1-nonprod]
    user = ukdba
    password = *****
    host = 127.0.0.1
    port = 3307
    [mysql1-euw1-prod]
    user = ukdba
    password = *****
    host = 127.0.0.1
    port = 3308
    [mysql1-euc1-nonprod]
    user = ukdba
    password = *****
    host = 127.0.0.1
    port = 3309
    [mysql1-euc1-prod]
    user = ukdba
    password = *****
    host = 127.0.0.1
    port = 3310

See "[Mysql - keeping your password
safe](Mysql_-_keeping_your_password_safe "wikilink")" for more details
on this utility

Once you connect successfully, then it will show you the port it has
proixied over.

Example:

    $ ./rds_connect

    1) mysql1-euw1-nonprod  3) mysql1-euc1-nonprod  5) Quit
    2) mysql1-euw1-prod 4) mysql1-euc1-prod
    Select endpoint to connect to: 2
    connecting to mysql1-euw1-prod.blah.eu-west-1.rds.amazonaws.com via <random bastion ip> over 3308
    use 'ssh -S mysql1-euw1-prod.blah.eu-west-1.rds.amazonaws.com -O exit <random bastion ip>' to manually disconnect
    Master running (pid=9839)
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 10269074
    Server version: 5.6.27-log MySQL Community Server (GPL)

    Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql>

From the output above, you can see it has opened port 3308 to the RDS
instance, which means we can connect from another terminal passing in
the login-path like so;

    $ mysql --login-path=mysql1-euw1-prod

    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 10269321
    Server version: 5.6.27-log MySQL Community Server (GPL)

    Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql>

You can also run the mysqldump command by passing the same login-path,
allowing you to dump RDS db's locally, or upload databases such as
during a migration

### The script

    #!/bin/bash

    # ssh -M -S my-ctrl-socket -fnNT -L <local port>:<rds end point>:<remote port eg.3306> <bastion ip> - creates tunnel with a socket name in the background
    # ssh -S my-ctrl-socket -O check <bastion ip> - show status of tunnel
    # ssh -S my-ctrl-socket -O exit <bastion ip> - quit the tunnel

    # EU Prod
    euprodbastion=("<bastion 1 ip in vpc>" "<bastion 2 ip in vpc>")
    euprodrds=("<rds endpoint in this vpc>")

    # EU Nonprod
    eunonprodbastion=("<bastion 1 ip in vpc>" "<bastion 2 ip in vpc>")
    eunonprod=("<rds endpoint in this vpc>")

    # UK Prod
    ukprodbastion=("<bastion 1 ip in vpc>" "<bastion 2 ip in vpc>")
    ukprodrds=("<rds endpoint in this vpc>")

    # UK Nonprod
    uknonprodbastion=("<bastion 1 ip in vpc>" "<bastion 2 ip in vpc>")
    uknonprodrds=("<rds endpoint in this vpc>")

    function usage() {
      echo "Choose an RDS instance to connect to. This script relies on having your instances set up correctly within the script, with both the endpoint at the bastion hosts filled. Check out the options block within."
      echo "It also relies on having your '--login-path's set up correctly using mysql_config_editor. Check the man page for that info. Currently on this machine its set up as;"
      mysql_config_editor print --all
    }

    RANDOM=$$$(date +%s)
    PS3='Select endpoint to connect to: '
    options=("mysql1-euw1-nonprod" "mysql1-euw1-prod" "mysql1-euc1-nonprod" "mysql1-euc1-prod" "Quit")
    select opt in "${options[@]}"
    do
      case $opt in
        "mysql1-euw1-nonprod")
          RDS=${eunonprod}
          PORT=3307
          BASTION=${uknonprodbastion[$RANDOM % ${#uknonprodbastion[@]} ]} # picks a random bastion box
          break
          ;;
        "mysql1-euw1-prod")
          RDS=${euprod}
          PORT=3308
          BASTION=${ukprodbastion[$RANDOM % ${#ukprodbastion[@]} ]}
          break
          ;;
        "mysql1-euc1-nonprod")
          RDS=${uknonprod}
          PORT=3309
          BASTION=${eunonprodbastion[$RANDOM % ${#eunonprodbastion[@]} ]}
          break
          ;;
        "mysql1-euc1-prod")
          RDS=${ukprod}
          PORT=3310
          BASTION=${euprodbastion[$RANDOM % ${#euprodbastion[@]} ]}
          break
          ;;
        "Quit")
          exit
          ;;
        *)
          echo "Invalid option"
          usage
          ;;
      esac
    done

    echo "connecting to $RDS via $BASTION over $PORT"
    echo "use 'ssh -S $RDS -O exit $BASTION' to manually disconnect"

    ssh -M -S $RDS -fnNT -L $PORT:$RDS:3306 $BASTION
    ssh -S $RDS -O check $BASTION

    mysql --login-path=$opt

    ssh -S $RDS -O exit $BASTION