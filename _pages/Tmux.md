[category: linux](category:_linux "wikilink") taken from
[here](https://robots.thoughtbot.com/a-tmux-crash-course)

(prefix is generally CTRL + B)

## create a new tmux session named session_name

`tmux new -s session_name`

## attach to an existing tmux session named session_name

`tmux attach -t session_name`

## switch to an existing session named session_name

`tmux switch -t session_name`

## list existing tmux sessions

`tmux list-sessions`
`  `

## detach the currently attached session

`tmux detach (prefix + d)`