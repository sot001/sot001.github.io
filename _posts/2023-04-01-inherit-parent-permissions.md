---
title: inherit-parent-permissions
date: '2023-04-01 19:37:56 +0000'
categories:
- inherit-parent-permissions
tags:
- inherit-parent-permissions
---


Disk needs to be mounted with acl (ie. /dev/cmc_ftp/cmc_vol
/usr/local/jail2 ext4 defaults,<b>acl</b> 0 0)

if required, remount the disk with the new options via;

`mount -o remount /usr/locaL/jail2`

check current settings on a directory via getfacl;

    shell> getfacl SD
    # file: SD
    # owner: adstream
    # group: sftpuser
    # flags: -s-
    user::rwx
    group::rwx
    other::r-x

change with setfacl;

    shell>  setfacl --test -R -d -m g::rwX,o::rwX adstream
    adstream: *,d:u::rwx,d:g::rwx,d:o::rwx
    adstream/SD: *,d:u::rwx,d:g::rwx,d:o::rwx
    adstream/HD: *,d:u::rwx,d:g::rwx,d:o::rwx
    adstream/HD/testfile: *,*

**--test** will list the changes, rather than applying them

    setfacl -R -d -m g::rwX,o::rwX adstream

This will **-R**ursively apply setfacl to the adstream directory,
<b>-m</b>odifying the **-d**efault ACLs – those that will be applied to
newly created items. (Uppercase X means only directories will receive
the +x bit.)

(If needed, you can add a u:someuser:rwX or g:someuser:rwX – preferably
a group – to the ACLs.)

### removing file ACL's

    setfacl -bn Inbound