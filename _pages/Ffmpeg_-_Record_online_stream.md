`#!/bin/bash`

`STREAM=$1`
`` DURATION=`echo ${2}*60 | bc` ``
`LOCATION=/tmp/`
`FILE=triplej.wma2`
`NEWFILE="${`[`FILE:0:${#FILE}-5`](FILE:0:$%7B#FILE%7D-5)`}.flac"`

`cd $LOCATION`
`mplayer -v -dumpstream -dumpfile $FILE $STREAM &> stream.log &`

`sleep 5`
`# get the pid of all processes started in this script.`
`` PIDS=`/sbin/pidof /usr/bin/mplayer` ``

`# the & turns the capture into a background job`
`sleep $DURATION  # wait for the show to be over`

`kill $PIDS # kill the stream capture`

`# encode for seeking`
`echo "encoding now " >> stream.log`

`ffmpeg -y -i $FILE -acodec flac -map_meta_data 0:0 $NEWFILE >> stream.log 2>&1 &`
` `
`sleep 5`
``PIDS=`/sbin/pidof /usr/bin/fmpeg` # just in case ffmpeg spirals out of control``
`sleep $2  # wait for the show to be over`

`kill $PIDS`

`sleep 5`
`rm $FILE`
` `
`exit 0`

usage: ./record_triplej.sh
<mms://a1863.l11289751862.c112897.g.lm.akamaistream.net/D/1863/112897/v0001/reflector:51862>
180