use the '\\r' combo instead of '\\n'

`hostname,hostalias,hostaddress,hoststate`
`:%s/,/\r/g`

`hostname`
`hostalias`
`hostaddress`
`hoststate`

To go back the other way, use '\\n' instead of '\\r'..weird

`:%s/\n/,/g`