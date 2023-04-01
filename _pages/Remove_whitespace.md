In a search, \\s finds whitespace (a space or a tab), and \\+ finds one
or more occurrences.

This removes whitespace from the end of the line

`:%s/\s\+$//`

This removes from the start of the line

`:%s/^\s\+//`