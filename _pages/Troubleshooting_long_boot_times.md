(ref:
<https://www.thegoodpenguin.co.uk/blog/reducing-boot-time-with-systemd/>)

`systemd-analyze time`

command provides an overview of the overall system boot time
(https://www.freedesktop.org/software/systemd/man/systemd-analyze.html\#systemd-analyze%20time)

`systemd-analyze blame `

This command prints a list of all running units, ordered by the time
they took to initialize
(https://www.freedesktop.org/software/systemd/man/systemd-analyze.html\#systemd-analyze%20blame)

`systemctl list-dependencies `<unit>

Shows units required and wanted by the specified units.
(https://www.freedesktop.org/software/systemd/man/systemctl.html)

`systemd-analyze critical-chain `<unit>

This command prints a tree of the time-critical chain of units (for each
of the specified UNITs or for the default target otherwise).
(https://www.freedesktop.org/software/systemd/man/systemd-analyze.html\#id-1.5.6)