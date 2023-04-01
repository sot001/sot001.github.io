---
title: nagios---checking-quorum-drives
date: '2023-04-01 19:37:57 +0000'
categories:
- nagios---checking-quorum-drives
tags:
- nagios---checking-quorum-drives
---


shell script for checking quorum drives on multiple windows nodes

    #!/bin/bash

    # check_quorum.sh
    #
    # K Sotiroff 23 Oct 2014
    #
    # checks quorum drives no matter what node they sit on.
    #

    usage () {
        echo "Usage: $0 -H hosts (comma separated list) -w warning -c critical -d drive";
        return
    }

    # check for incoming options
    if [ $# -lt 4 ] # we expect 4 options
    then
            usage;
            exit 1
    fi

    # get arguments
    hosts=  critical= warning= drive=

    while getopts H:w:d:c: opt
    do
            case $opt in
            H)      hosts=($OPTARG)
                    ;;
            c)      critical=$OPTARG
                    ;;
            w)      warning=$OPTARG
                    ;;
            d)      drive=$OPTARG
                    ;;
            '?')    echo "$0: invalid option -$OPTARG" >&2
                    usage;
                    exit 1
                    ;;
            esac
    done

    shift $((OPTIND -1))

    oIFS="$IFS"; # save the field seperator
    IFS=,;  # set the new field separator to ,
    set -- $hosts; # split the hosts variable into an array based on IFS
    IFS="$oIFS"; # set it back to default

    # now loop it
    for thishost in "$@"; do
        result=$(/usr/local/nagios/libexec/check_nt -H $thishost -v USEDDISKSPACE -p 1248 -l $drive -w $warning -c $critical );
        found=$(echo $result | grep -c "Invalid drive");

        # found it, no need to go any further.
        if [["$found"_==_"0"|"$found" == "0"]]; then
            echo $result;
            exit 0;
        fi
    done

    # oops, something went wrong
    echo "Critical: Cannot find Quorum drive on any node. Checked $hosts";
    exit 2;

The command config is;

    define command{
    command_name    check_quorum
    command_line    $USER1$/check_quorum.sh -H $ARG1$ -w $ARG2$ -c $ARG3$ -d $ARG4$
    }

and the service config inside the host is;

    define service{
        host_name                   servercluster
        service_description         Q Quorum Drive
        use                         live_service
        check_command               check_quorum!servernode01,servernode02!10%!5%!q
    }