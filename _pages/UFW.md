[category: security](category:_security "wikilink")

### status

    root@remote:/var/log# ufw status
    Status: active

    To                         Action      From
    --                         ------      ----
    22                         ALLOW       Anywhere
    80/tcp                     ALLOW       Anywhere
    25565                      ALLOW       Anywhere
    25566                      ALLOW       Anywhere

or

    root@remote:/var/log# ufw status numbered
    Status: active

         To                         Action      From
         --                         ------      ----
    [ 1] 22                         ALLOW IN    Anywhere
    [ 2] 80/tcp                     ALLOW IN    Anywhere
    [ 3] 25565                      ALLOW IN    Anywhere
    [ 4] 25566                      ALLOW IN    Anywhere
    [ 5] 9019                       ALLOW IN    Anywhere
    [ 8] Anywhere                   DENY IN     9019
    [ 9] 22 (v6)                    ALLOW IN    Anywhere (v6)
    [10] 80/tcp (v6)                ALLOW IN    Anywhere (v6)
    [11] 25565 (v6)                 ALLOW IN    Anywhere (v6)
    [12] 25566 (v6)                 ALLOW IN    Anywhere (v6)
    [13] 9019 (v6)                  ALLOW IN    Anywhere (v6)
    [14] Anywhere (v6)              DENY IN     9019 (v6)

### adding

    root@remote:/var/log# ufw allow 443
    Rule added
    Rule added (v6)

Allow from specific ip

    ufw allow from 88.99.88.99 to any port 8080

### removing

    root@remote:/home/debian-transmission# ufw delete allow 443
    Rule deleted
    Rule deleted (v6)

### deleting

    root@remote:/var/log# ufw status numbered
    Status: active

         To                         Action      From
         --                         ------      ----
    [ 1] 22                         ALLOW IN    Anywhere
    [ 2] 80/tcp                     ALLOW IN    Anywhere
    [ 3] 25565                      ALLOW IN    Anywhere
    [ 4] 25566                      ALLOW IN    Anywhere
    [ 5] 9019                       ALLOW IN    Anywhere
    [ 6] 9019                       ALLOW IN    111.222.33.44
    [ 7] 9019                       ALLOW IN    11.22.33.44
    [ 8] Anywhere                   DENY IN     9019
    [ 9] 22 (v6)                    ALLOW IN    Anywhere (v6)
    [10] 80/tcp (v6)                ALLOW IN    Anywhere (v6)
    [11] 25565 (v6)                 ALLOW IN    Anywhere (v6)
    [12] 25566 (v6)                 ALLOW IN    Anywhere (v6)
    [13] 9019 (v6)                  ALLOW IN    Anywhere (v6)
    [14] Anywhere (v6)              DENY IN     9019 (v6)

    root@remote:/var/log# ufw delete 5
    Deleting:
     allow 9019
    Proceed with operation (y|n)? y
    Rule deleted
    root@remote:/var/log# ufw status
    Status: active

    To                         Action      From
    --                         ------      ----
    22                         ALLOW       Anywhere
    80/tcp                     ALLOW       Anywhere
    25565                      ALLOW       Anywhere
    25566                      ALLOW       Anywhere
    9019                       ALLOW       122.44.55.66
    9019                       ALLOW       11.22.33.44
    Anywhere                   DENY        9019
    22 (v6)                    ALLOW       Anywhere (v6)
    80/tcp (v6)                ALLOW       Anywhere (v6)
    25565 (v6)                 ALLOW       Anywhere (v6)
    25566 (v6)                 ALLOW       Anywhere (v6)
    9019 (v6)                  ALLOW       Anywhere (v6)
    Anywhere (v6)              DENY        9019 (v6)

### Deny by specific IP

***sudo ufw deny from <ip address>***

<example:To> block packets from 207.46.232.182:

`sudo ufw deny from 207.46.232.182`

### Deny by specific port and IP address

***sudo ufw deny from <ip address> to <protocol> port <port number>***

example: deny ip address 192.168.0.1 access to port 22 for all protocols

`sudo ufw deny from 192.168.0.1 to any port 22`

[Category: firewall](Category:_firewall "wikilink")
[Category:ufw](Category:ufw "wikilink")