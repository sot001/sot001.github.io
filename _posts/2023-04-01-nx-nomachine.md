---
title: nx-nomachine
date: '2023-04-01 19:37:57 +0000'
categories:
- nx-nomachine
tags:
- nx-nomachine
---


Use FREENX on the server and install the client on your windows box. lot
less farting about that way.

### caps lock reversed in NX

focus on the NX window, hit CTRL + ALT + DEL then hit caps lock button
and ESC to get back. should be in sync again

### connection error

If you can't connect from the client, find the server key and import it
into the client.

error looks like this;

    NX> 203 NXSSH running with pid: 9232
    NX> 285 Enabling check on switch command
    NX> 285 Enabling skip of SSH config files
    NX> 285 Setting the preferred NX options
    NX> 200 Connected to address: 87.81.201.136 on port: 222
    NX> 202 Authenticating user: nx
    NX> 208 Using auth method: publickey
    NX> 204 Authentication failed.

import the key like so

```
 cat /etc/nxserver/client.id_dsa.key
-----BEGIN DSA PRIVATE KEY-----
MI.....
-----END DSA PRIVATE KEY-----
```

click configure, the under Server part click Key button and past in the
private key. that should do it.

#### NX may not start on Centos 7

edit the file /usr/NX/etc/server.cfg and check the SSHAuthorizedKeys key
corresponds to the name of the SSH authorized key file in use and
specified in the SSHD configuration file. Might not be
authorized_keys2...

#### Full NX install

This may not work for much longer, its getting a little old in the tooth

install .deb packages via;

    dpkg -i nxnode_3.5.0-7_i386.deb nxserver_3.5.0-9_i386.deb nxclient_3.5.0-7_i386.deb

this may fail with a message along the lines of
'/usr/lib/cups/backend/nx no file or directory'. the install file seems
to have a line break in it, so run this to create the symlink:

    ln -sf /usr/NX/bin/nxspool /usr/lib/cups/backend/nx

then run the install line again and it \*should\* work.

check your user is set up

    /usr/NX/bin/nxserver --userauth ''mythtv''

if not, set it up:

    /usr/NX/bin/nxserver --useradd mythtv

that should be it.