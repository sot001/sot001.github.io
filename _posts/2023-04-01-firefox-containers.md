---
title: firefox-containers
date: '2023-04-01 19:37:56 +0000'
categories:
- firefox-containers
tags:
- firefox-containers
---


### Order containers

(on MacOS) Quit firefox first\!\!

    pip install ff-containers-sort

    ff-containers-sort

### Editing by hand

(on MAcOS) Quit firefox first\!\!

    vi "./Application Support/Firefox/Profiles/tcqkllhg.default-release/containers.json"

    (to see it 'pretty printed')
    :$!python -m json.tool