[category: ubuntu](category:_ubuntu "wikilink")
[category:ufw](category:ufw "wikilink")
[category:firewall](category:firewall "wikilink") [category:windows
10](category:windows_10 "wikilink")

### UFW rules allowing Samba

```

To                         Action      From
--                         ------      ----
137/udp                    ALLOW       192.168.10.0/24
138/udp                    ALLOW       192.168.10.0/24
139/tcp                    ALLOW       192.168.10.0/24
445/tcp                    ALLOW       192.168.10.0/24
```

### connecting from Windows 10

Run Windows PowerShell as 'Administrator'

Enter the following commands:

`sc.exe config lanmanworkstation depend= bowser/mrxsmb10/nsi`
`sc.exe config mrxsmb20 start= disabled`

and reboot