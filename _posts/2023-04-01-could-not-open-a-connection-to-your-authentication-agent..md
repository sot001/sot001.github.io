---
title: could-not-open-a-connection-to-your-authentication-agent.
date: '2023-04-01 19:37:55 +0000'
categories:
- could-not-open-a-connection-to-your-authentication-agent.
tags:
- could-not-open-a-connection-to-your-authentication-agent.
---


    $ ssh-add
    Could not open a connection to your authentication agent.

start up the ssh-agent

    $ eval `ssh-agent -s`
    Agent pid 17715

Try it again, it should work

    $ ssh-add
    Enter passphrase for /home/sotirk/.ssh/id_rsa:
    Identity added: /home/sotirk/.ssh/id_rsa (/home/sotirk/.ssh/id_rsa)
    $ git push -u origin master
    Branch master set up to track remote branch master from origin.
    Everything up-to-date