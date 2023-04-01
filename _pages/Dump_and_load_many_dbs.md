create a file with a list of the db's to be transferred, eg;

`db1`
`db2`
`db3`

run a script (eg. dumpandload.sh) ;

`if [ $# -ne 3 ] `
`then`
`        echo "Usage: $0 source sink dblistfile"`
`        echo`
`        exit 1`
`fi`
`source=$1`
`sink=$2`
`dbs=$3`

``for db in `cat $dbs`; do``
` echo dumping $db from $source;`
`` mysqldump -h $source $db > $db.`date +%Y%m%d`.dump;``
` echo dump done, importing $db to $sink;`
`` mysql -h $sink $db < $db.`date +%Y%m%d`.dump;``
` echo import $db done;`
`done`