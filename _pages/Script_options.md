use getopts, for example;

    #!/bin/bash

    if [ $# -lt 6 ] # we expect 6 options, 1 for each switch and 1 for each value
    then
            echo "Usage: $0 -v vhost -u user -c cluster" >&2
            exit 1
    fi

    # get arguments
    vhost=  user= cluster=

    while getopts v:u:c: opt
    do
            case $opt in
            v)      vhost=$OPTARG
                    ;;
            c)      cluster=$OPTARG
                    ;;
            u)      user=$OPTARG
                    ;;
            '?')    echo "$0: invalid option -$OPTARG" >&2
                    echo "Usage: $0 -v vhost -u user -c cluster" >&2
                    exit 1
                    ;;
            esac
    done

    shift $((OPTIND -1))

    # generate password of passed length
    ...