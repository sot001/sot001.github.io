---
title: send-email-when-user-ssh-s-in
date: '2023-04-01 19:37:58 +0000'
categories:
- send-email-when-user-ssh-s-in
tags:
- send-email-when-user-ssh-s-in
---


### Ubuntu

in /etc/sshd/sshrc;

    ip=`echo $SSH_CONNECTION | cut -d " " -f 1`

    logger -t ssh-wrapper $USER login from $ip
    echo "User $USER just logged in from $ip" | mail -q -s "SSH Login" "Admin<admin@example.com>"

### Centos

create a file /etc/ssh/login-notify.sh;

    #!/bin/sh

    # Change these two lines:
    sender="root@box.to.be.monitored"
    recepient="admin@example.com"

    if [ "$PAM_TYPE" != "close_session" ]; then
        host="`hostname`"
        subject="SSH Login: $PAM_USER from $PAM_RHOST on $host"
        # Message to send, e.g. the current environment variables.
        message="`env`"
        echo "$message" | mailx -r "$sender" -s "$subject" "$recepient" &
    fi

then add a line to /etc/pam.d/sshd;

`session optional pam_exec.so seteuid /etc/ssh/login-notify.s`