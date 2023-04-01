(Ref: <https://www.revsys.com/writings/quicktips/ssh-tunnel.html>)

    ssh -f user@personal-server.com -L 2000:personal-server.com:25 -N

The -f tells ssh to go into the background just before it executes the
command. This is followed by the username and server you are logging
into. The -L 2000:personal-server.com:25 is in the form of -L
local-port:host:remote-port. Finally the -N instructs OpenSSH to not
execute a command on the remote system.

(Ref: <https://www.howtogeek.com/168145/how-to-use-ssh-tunneling/>)

“Local port forwarding” allows you to access local network resources
that aren’t exposed to the Internet. For example, let’s say you want to
access a database server at your office from your home. For security
reasons, that database server is only configured to accept connections
from the local office network. But if you have access to an SSH server
at the office, and that SSH server allows connections from outside the
office network, then you can connect to that SSH server from home and
access the database server as if you were in the office.

To do this, you establish an SSH connection with the SSH server and tell
the client to forward traffic from a specific port from your local
PC—for example, port 1234—to the address of the database’s server and
its port on the office network. So, when you attempt to access the
database server at port 1234 your current PC, “localhost”, that traffic
is automatically “tunneled” over the SSH connection and sent to the
database server. The SSH server sits in the middle, forwarding traffic
back and forth. You can use any command line or graphical tool to access
the database server as if it was running on your local PC.

To use local forwarding, connect to the SSH server normally, but also
supply the -L argument. The syntax is:

    ssh -L local_port:remote_address:remote_port username@server.com

### Dynamic Port Forwarding: Use Your SSH Server as a Proxy

There’s also “dynamic port forwarding”, which works similarly to a proxy
or VPN. The SSH client will create a SOCKS proxy you can configure
applications to use. All the traffic sent through the proxy would be
sent through the SSH server. This is similar to local forwarding—it
takes local traffic sent to a specific port on your PC and sends it over
the SSH connection to a remote location.

To use dynamic forwarding, run the ssh command with the -D argument,
like so:

    ssh -D local_port username@server.com

For example, let’s say you have access to an SSH server at
ssh.yourhome.com and your username on the SSH server is bob . You want
to use dynamic forwarding to open a SOCKS proxy at port 8888 on the
current PC. You’d run the following command:

    ssh -D 8888 bob@ssh.yourhome.com

You could then configure a web browser or another application to use
your local IP address (127.0.01) and port 8888. All traffic from that
application would be redirected through the tunnel.

### SSH Proxy Jump to remote Host

For a quick and dirty, use this;

    ssh -J <bastion-host> <remote-host>

For a more "robust" solution, read on....

I have a bastion server set up like this;

    Host Bastion
      Hostname  11.22.33.44
      IdentityFile ~/.ssh/bastion-20190626.pem
      User ec2-user
      StrictHostKeyChecking no
      LogLevel ERROR
      UserKnownHostsFile /dev/null

and my remote host like this;

    Host jenkins
      Hostname 10.12.131.94
      IdentityFile ~/.ssh/jenkins-20210621.pem
      ProxyCommand ssh -W %h:%p ec2-user@Bastion
      User ec2-user
      StrictHostKeyChecking no
      LogLevel ERROR
      UserKnownHostsFile /dev/null

so this allows me to

    scp myfile.txt jenkins:~

which tunnels overs the bastion and into the jenkins box.

This page :
<https://www.redhat.com/sysadmin/ssh-proxy-bastion-proxyjump> probably
explains it better

the beauty of this solution is he never leaves anything on an interim
server, it all goes straight to the jenkins server