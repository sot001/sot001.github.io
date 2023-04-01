small snippet to display a progress bar while you wait for the backend
to come online

`#`
`## start of k's code`
`#`
`export DISPLAY=:0.0`
`backend='192.168.10.101'`
`port=6544`
`count=0`
`maxattempts=10`
`` inc=`expr 100 / $maxattempts` ``
`checkcmd="nc -z $backend $port"`
`(`
`$checkcmd > /dev/null`
`while [ $? != 0 ] && [ $count -lt $maxattempts ]`
`do`
`        # wake the backend`
`        /storage/bin/wakemythbackend > /dev/null`
``         count=`expr $count + 1` ``
`        echo "# Waking up Back End. Attempt # $count of $maxattempts..."`
``         progress=`expr $count \* $inc` ``
`        echo $progress`
`        sleep 20`
`        $checkcmd`
`done`
`if [ $count -ge $maxattempts ]`
`then`
`    echo "# Could not start Back End. Exiting.." ; sleep 5`
`else`
`    echo "# Back end online! Starting MythFrontEnd" ; sleep 2`
`fi`
`echo "100" ;`
`) |`
`zenity --progress \`
`--title="MythFrontEnd Startup" \`
`--text="# Checking Back End available..." \`
`--percentage=0 \`
`--auto-close `

`$checkcmd`
`if [ $? != 0 ]`
`then`
`    exit 1;`
`fi`
`#`
`## end of k's code`
`#`