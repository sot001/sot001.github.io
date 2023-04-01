(from
<http://serverfault.com/questions/53080/how-to-enable-ssh-x11-forwarding-through-additional-server>)

Local linux box (llb) can ssh only to cube.example.org on port 212, from
cube can ssh to ninja;

Step 1; forward local port to port 22 on ninja

    user@workbench:~$ ssh -L 2222:ninja:22 -p 212 mythtv@cube.example.org

Step 2; in another terminal, connect to local port;

    user@workbench:~$ ssh -X -p 2222 localhost
    ..
    xclock