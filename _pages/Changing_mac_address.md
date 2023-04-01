get existing mac address of interface to change

`sudo ip addr`

get a look at existing mac's on network

`arp -a`

take down interface

`sudo ifdown `<interface>

change mac

`sudo ifconfig `<interface>` hw ether `<new address>

being interface back up

`sudo ifup `<interface>