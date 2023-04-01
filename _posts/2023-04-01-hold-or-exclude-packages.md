---
title: hold-or-exclude-packages
date: '2023-04-01 19:37:56 +0000'
categories:
- hold-or-exclude-packages
tags:
- hold-or-exclude-packages
---


  - Using apt

`sudo apt-mark hold package_name.`

  - Using

`dpkg echo "package_name hold" | sudo dpkg --set-selections.`

  - Using aptitude

`sudo aptitude hold package_name.`

  - Using apt

`sudo apt-mark unhold package_name.`

  - Using dpkg

`echo "package_name install" | sudo dpkg --set-selections.`

## List Packages on Hold

`sudo dpkg --get-selections | grep "hold"`

## Unhold or Include package in Install

  - Using apt

`sudo apt-mark unhold package_name`

  - Using dpkg

`echo "package_name install" | sudo dpkg --set-selections`

  - Using aptitude

`sudo aptitude unhold package_name`