---
title: mysql-log-search-script
date: '2023-04-01 19:37:57 +0000'
categories:
- mysql-log-search-script
tags:
- mysql-log-search-script
---


will search for a user in the mysql log

`#!/bin/bash`

``today=`date +"%y%m%d"`;``
`echo "Enter the date range you want the extract from;"`
`read -p "From: [$today]" from`
`from=${from:=$today}`
`read -p "To: [$today]" to`
`to=${to:=$today}`
`read -p "Name of logfile: " logfile`
`read -p "Name of output file: [output.log]" outfile`
`outfile=${outfile:="output.log"}`
`user="dbuser[dbuser]"`
`while read t1 t2 t3 restofline`
`do`
`    if [ "$t2" = "Time:" ] && [ $t3 -ge $from ] && [ $t3 -le $to ];`
`    then`
`        echo "$t1 $t2 $t3 $restofline";`
`        while read t1 t2 t3 restofline;`
`        do`
`            if [ "$t3" = "$user" ];`
`            then`
`                echo "$t1 $t2 $t3 $restofline";`
`                read t1 t2 t3 restofline;`
`                while [ "$t2" != "User@Host:" ];`
`                do`
`                    echo "$t1 $t2 $t3 $restofline";`
`                    read t1 t2 t3 restofline;`
`                done;`
`            fi;`
`        done;`
`    fi;`
`done < $logfile > $outfile`

  -   - Warning\! this will run on and on if there isn't another line
        starting with User@Host' in the file probably needs a 'max line'
        variable in the loop to stop it writing a million (or 15 million
        in my case..) empty lines to a file before you catch it