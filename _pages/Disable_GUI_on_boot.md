edit /etc/default/grub and change the following line;

` GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`

to

`GRUB_CMDLINE_LINUX_DEFAULT="text"`

then run

`sudo update-grub`

startx will start the gui