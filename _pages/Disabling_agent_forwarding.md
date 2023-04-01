To log in to another host without carrying all your keys acorss you can
do

`ssh -a host`

or to make it permanent, whack the following line in your .ssh/config
file

`ForwardAgent        no`