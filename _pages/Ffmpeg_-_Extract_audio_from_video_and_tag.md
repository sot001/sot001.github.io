ensure video files are named with the following format (only 1 - in the
filename;

<artist>` - `<song>`.`<ext>

`for file in *.flv; do `
` filename=${`[`file:0:${#file}-4`](file:0:$%7B#file%7D-4)`};`
` ffmpeg -i "$file" -acodec libmp3lame -aq 4 "$filename.mp3"; `
`` artist=`echo $filename| awk -F " - " '{print $1}'`; ``
`` title=`echo $filename| awk -F " - " '{print $2}'`; ``
` id3tool -a YouTube -r "$artist" -t "$title" "$filename.mp3"; `
`done`

or to take an argument;

`file=$1`
`filename=${`[`file:0:${#file}-4`](file:0:$%7B#file%7D-4)`};`

`ffmpeg -i "$file" -acodec libmp3lame -aq 4 "$filename.mp3";`
``artist=`echo $filename| awk -F " - " '{print $1}'`;``
``title=`echo $filename| awk -F " - " '{print $2}'`;``
`id3tool -a YouTube -r "$artist" -t "$title" "$filename.mp3";`
`id3tool "$filename.mp3";`

or, run

`/storage/contrib/mp3erizer.sh`