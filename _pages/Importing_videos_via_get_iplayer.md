stop firewall

`sudo service pgl stop`

get video(s)

`/storage/contrib/get_iplayer "Australia with Simon Reeve" --get`

import into mythtv. be prepared to find the description etc and enter
them at the same time

`/usr/local/storage/contrib/myth.rebuilddatabase.pl --ext mp4 --dir /storage/recordings`
`import?`
`channel?`
`title?`
`subtitle?`
`description?`
`starttime?`
`duration?`
`rebuild seek table?`

and here's a script i whipped up:

`#!/bin/bash`
`# download_bbcshow.sh`
`# requires: get_iplayer, myth.rebuilddatabase.pl & pgl (but only if you use it for security)`
`#`
`if [ -z "$1" ]; then`
`        echo "you didn't pass a show title";`
`        echo "Usage: $0 'Title'";`
`        exit 0;`
`fi`

`SHOW="$1";`

`echo "Looking for $SHOW";`

`cd /storage/recordings`
`/storage/contrib/get_iplayer --refresh`
`sudo service pgl stop`
`/storage/contrib/get_iplayer --nocopyright --metadata generic --get --modes=best "$SHOW"`
`for xmlfile in *.xml; do`
`        if [ -e $xmlfile ]; then`
`                import="y"`
`                channel="106"`
``                 title=`xml_grep 'name' $xmlfile --text_only` ``
``                 filename=`xml_grep 'filename' $xmlfile --text_only | awk -F/ '{print $5}'` ``
``                 subtitle=`xml_grep 'title' $xmlfile --text_only` ``
``                 description=`xml_grep 'desc' $xmlfile --text_only` ``
``                 date=`xml_grep 'dldate' $xmlfile --text_only` ``
``                 time=`xml_grep 'dltime' $xmlfile --text_only` ``
`                starttime="$date $time"`
`                duration="60"`
`                rebuild="y"`
`                rm $xmlfile`
`                /usr/local/storage/contrib/myth.rebuilddatabase.pl --dir /storage/recordings --file "$filename" --answer "$import" --answer \ `
`"$channel" --answer "$title" --answer "$subtitle" --answer "$description" --answer "$starttime" --answer "$duration" --answer "$rebuild"`
`        fi`
`done`
`sudo service pgl start`

afterwards it'll show up in your recorded programs list.