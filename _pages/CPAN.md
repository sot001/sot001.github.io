running CPAN shell via

    perl -MCPAN -e 'shell'

change options via

    o conf

this lists out all config options. set a particular one like so (example
http_proxy)

    o conf init http_proxy
    o conf username yumupdates

to save;

    o conf commit