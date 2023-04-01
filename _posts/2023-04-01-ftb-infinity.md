---
title: ftb-infinity
date: '2023-04-01 19:37:56 +0000'
categories:
- ftb-infinity
tags:
- ftb-infinity
---


Ubuntu headless server, 4G RAM, 2x dual core CPU

\~minecraft is home dir

### upgrading

Backup the current server

    cd ~/minecraft
    tar -zcvf ftb.<old version>.tar.gz ftb/

Move side by side:

`mv ftb ftb.bak`

Make the server folder again

`mkdir ftb`
`chown minecraft:minecraft ftb`

Copy over everything but configs and mods:

`rsync -av --progress --exclude mods --exclude config --exclude libraries --exclude scripts ftb.bak/ ftb/`

Get and unzip new server to Infinity folder

`unzip FTBInfinityServer.zip -d ftb`
`chown -R minecraft:minecraft ftb/`

Run the install script in the Infinity folder

`cd ftb`
`chmod +x FTBInstall.sh`
`./FTBInstall.sh`

create a symlink to the new jar file so the init script still works

`ln -s  FTBServer-1.7.10-1448.jar FTBServer.jar`

first time you start it up, run it with 'screen' so you can confirm any
missing blocks