[category:firewall](category:firewall "wikilink")[category:fail2ban](category:fail2ban "wikilink")

### Check jail status

`fail2ban-client status `<jail>

eg;

    remote fail2ban # fail2ban-client status nextcloud
    Status for the jail: nextcloud
    |- filter
    |  |- File list:    /home/nextcloud/data/nextcloud.log
    |  |- Currently failed: 0
    |  `- Total failed: 0
    `- action
       |- Currently banned: 0
       |  `- IP list:
       `- Total banned: 0

### unban IP from jail

`fail2ban-client set nextcloud unbanip `<ip>

eg;

    remote fail2ban # fail2ban-client status nextcloud
    Status for the jail: nextcloud
    |- filter
    |  |- File list:    /home/nextcloud/data/nextcloud.log
    |  |- Currently failed: 0
    |  `- Total failed: 3
    `- action
       |- Currently banned: 1
       |  `- IP list:   21.17.43.19
       `- Total banned: 1



    remote fail2ban # fail2ban-client set nextcloud unbanip 21.17.43.19
    217.147.243.129



    remote fail2ban # fail2ban-client status nextcloud
    Status for the jail: nextcloud
    |- filter
    |  |- File list:    /home/nextcloud/data/nextcloud.log
    |  |- Currently failed: 0
    |  `- Total failed: 3
    `- action
       |- Currently banned: 0
       |  `- IP list:
       `- Total banned: 1

### Remove IP from blocklist

check its being blocked by running

`iptables -L -n`

if it is, unblock it by running

`iptables -D `<CHAIN>` -s `<IP>`  -j `<ACTION>

where <IP> is the one you want to remove, <ACTION> is what it does and
<CHAIN> is the ruleset its blocked under. Some examples below;

    iptables -L -n
    ...
    Chain f2b-default (2 references)
    target     prot opt source               destination
    REJECT     all  --  217.147.243.129      anywhere             reject-with icmp-port-unreachable
    RETURN     all  --  anywhere             anywhere
    ...
    iptables -D f2b-default -s 217.147.243.129 -j REJECT # remove it

### Whitelisting

Whitelisting is setup in the jail.conf file using a space separated
list.

    [DEFAULT]
    # "ignoreip" can be an IP address, a CIDR mask or a DNS host. Fail2ban will not
    # ban a host which matches an address in this list. Several addresses can be
    # defined using space separator.

    ignoreip = 127.0.0.1 192.168.1.0/24 8.8.8.8

    # This will ignore connection coming from common private networks.
    # Note that local connections can come from other than just 127.0.0.1, so
    # this needs CIDR range too.
    ignoreip = 127.0.0.0/8 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16

[Category: iptables](Category:_iptables "wikilink")