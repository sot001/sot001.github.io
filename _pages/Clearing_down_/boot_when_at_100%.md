(Ref:
<https://gist.github.com/ipbastola/2760cfc28be62a5ee10036851c654600>)

``sudo dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v `uname -r`| while read -r line; do sudo apt-get -y purge $line;done;sudo apt-get autoremove; sudo update-grub``