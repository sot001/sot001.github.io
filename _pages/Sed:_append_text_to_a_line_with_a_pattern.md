The following will append ',doubletake_servers' to the end of a line
containing 'hostgroups'

`sed '/hostgroups/ s/$/ ,doubletake_servers/' filename.cfg`