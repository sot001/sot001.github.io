---
title: ubuntu-on-windows--wsl2-
date: '2023-04-01 19:37:58 +0000'
categories:
- ubuntu-on-windows--wsl2-
tags:
- ubuntu-on-windows--wsl2-
---


Go through the normal route of installing WSL2 then follow below for
terminator instructions;

1.  install VcXsrv for X11 (tried with cygwin but terminator rendered
    badly on secondary desktops) on windows
2.  install xfce4 and xfce4-goodies on ubuntu
3.  install terminator and test it opens. If you have installed the
    zshrc file from
    [here](https://raw.githubusercontent.com/sot001/dotfiles/master/wsl2_work_zshrc)
    it should work. Otherwise you might need to fool with your DISPLAY
    variable
4.  following instructions from
    [here](https://medium.com/javarevisited/using-wsl-2-with-x-server-linux-on-windows-a372263533c3)
    create a vbs file in order to launch terminator from a shortcut
    (copy of script used is in dotfiles repo)