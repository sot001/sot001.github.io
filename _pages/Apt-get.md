#### apt-get update

refreshes package info

#### apt-get upgrade

will upgrade packages without installing new packages or removing old
ones. keep the box 'as it is'. Will fail if it needs a new package for
dependency reasons

#### apt-get dist-upgrade

as above, except all dependencies are also installed

#### apt-cache search

gives info on the package. eg;

    root@cube:/etc/apache2# apt-cache search mythtv
    hdhomerun-config - Configuration utility for Silicon Dust HD HomeRun
    hdhomerun-config-gui - GUI Configuration utility for Silicon Dust HD HomeRun
    libhdhomerun-dev - Development library for Silicon Dust HD HomeRun
    libhdhomerun1 - Library for Silicon Dust HD HomeRun
    mythbuntu-bare-client - Mythbuntu Bare Client
    mythbuntu-bare-console - Mythbuntu Bare Console
    ...

#### apt-cache show

shows detailed info on package. must supply package name. eg;

    root@cube:/etc/apache2# apt-cache show mythtv
    Package: mythtv
    Priority: optional
    Section: graphics
    Installed-Size: 102
    Maintainer: MythTV Ubuntu Maintainers <ubuntu-mythtv@lists.ubuntu.com>
    Architecture: all
    Version: 2:0.27.3+fixes.20140908.2d4a7c9-0ubuntu0mythbuntu2
    Suggests: mythtv-doc
    ...