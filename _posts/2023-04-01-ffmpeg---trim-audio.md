---
title: ffmpeg---trim-audio
date: '2023-04-01 19:37:56 +0000'
categories:
- ffmpeg---trim-audio
tags:
- ffmpeg---trim-audio
---


Provide the start point (-ss) and the duration in seconds (-t) to ffmpeg
to trim a file;

`ffmpeg -ss 00:00:15 -t 263 -i "this music is too long.mp3" test.mp3`

NOTE: avconv is a fork of mpeg for ubuntu 14.04