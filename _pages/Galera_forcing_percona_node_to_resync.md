Switching the server off then removing the database directory will cause
the node to come up and not sync. It thinks all is ok, but doesn't
realise the rug has been pulled from under its feet.

To force a resync, shut the service down then remove / rename the
grastate.dat file as this is where it stores its state. Starting the
node up again will cause an SST transfer