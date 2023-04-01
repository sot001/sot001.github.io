To create htpasswd accounts from command line use;

    shell > printf "someuser:`openssl passwd -apr1`\n"
    Password:
    Verifying - Password:
    someuser:$apr1$7xVW3W85$y2M/Ll0Fv/2YDbuV3PCrC1

Paste that into htpasswd file