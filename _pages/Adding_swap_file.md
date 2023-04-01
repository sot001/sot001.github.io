[category: linux](category:_linux "wikilink") [category:
sysadmin](category:_sysadmin "wikilink") Create the new file (14Gig in
this example) using fallocate as its quicker than dd

`fallocate -l 14G /mnt/lvm_log/swapfile`

now make it rw only by root

`chmod 600 /mnt/lvm_log/swapfile`

now make it a swap file

`mkswap /mnt/lvm_log/swapfile`

swap on to it

`swapon /mnt/lvm_log/swapfile`

check the loveliness

`[root@db01 log]# swapon --summary`
`Filename               Type        Size    Used    Priority`
`/dev/dm-1                               partition  4128764 23416   -1`
`/mnt/lvm_log/swapfile                   file       14680060    0   `

add it to fstab

`vi /etc/fstab `
`.....`
`# new swap file`
`/mnt/lvm_log/swapfile  none    swap    defaults    0 0`