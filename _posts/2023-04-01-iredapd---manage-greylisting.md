---
title: iredapd---manage-greylisting
date: '2023-04-01 19:37:56 +0000'
categories:
- iredapd---manage-greylisting
tags:
- iredapd---manage-greylisting
---


#### greylist disable a single account

use the python script: /opt/iredapd/tools/greylisting_admin.py

eg;

`python /opt/iredapd/tools/greylisting_admin.py --disable --to user@domain.tld`

This will disable greylisting for this account

#### Display current status

    gateway ~ # python /opt/iredapd/tools/greylisting_admin.py --list
    Sender                             -> Local Account                  Status
    ------------------------------------------------------------------------------
    @. (anyone)                        -> user@domain.tld           disabled
    sender.email@somedomain.tld         -> @. (anyone)                    disabled
    @. (anyone)                        -> @. (anyone)                    enabled

#### White/black listing

Use the wblist_admin.py tool located here:
/opt/iredapd/tools/wblist_admin.py

    gateway postfix # python /opt/iredapd/tools/wblist_admin.py
    Usage:

        --outbound
            Manage white/blacklist for outbound messages.

            If no '--outbound' argument, defaults to manage inbound messages.

        --account account
            Add white/blacklists for specified (local) account. Valid formats:

                - a single user: username@domain.com
                - a single domain: @domain.com
                - entire domain and all its sub-domains: @.domain.com
                - anyone: @. (the ending dot is required)

            if no '--account' argument, defaults to '@.' (anyone).

        --add
            Add white/blacklists for specified (local) account.

        --delete
            Delete specified white/blacklists for specified (local) account.

        --delete-all
            Delete ALL white/blacklists for specified (local) account.

        --list
            Show existing white/blacklists for specified (local) account. If no
            account specified, defaults to manage server-wide white/blacklists.

        --whitelist sender1 [sender2 sender3 ...]
            Whitelist specified sender(s). Multiple senders must be separated by a space.

        --blacklist sender1 [sender2 sender3 ...]
            Blacklist specified sender(s). Multiple senders must be separated by a space.

        WARNING: Do not use --list, --add-whitelist, --add-blacklist at the same time.

        --noninteractive
            Don't ask to confirm.

    Sample usage:

        * Show and add server-wide whitelists or blacklists:

            # python wblist_admin.py --add --whitelist 192.168.1.10 user@example.com
            # python wblist_admin.py --add --blacklist 172.16.1.10 baduser@example.com
            # python wblist_admin.py --list --whitelist
            # python wblist_admin.py --list --blacklist

        * For per-user or per-domain whitelists and blacklists, please use option
          `--account`. for example:

            # python wblist_admin.py --account user@mydomain.com --add --whitelist 192.168.1.10 user@example.com
            # python wblist_admin.py --account user@mydomain.com --add --blacklist 172.16.1.10 baduser@example.com
            # python wblist_admin.py --account user@mydomain.com --list --whitelist
            # python wblist_admin.py --account user@mydomain.com --list --blacklist