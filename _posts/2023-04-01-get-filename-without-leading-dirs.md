---
title: get-filename-without-leading-dirs
date: '2023-04-01 19:37:56 +0000'
categories:
- get-filename-without-leading-dirs
tags:
- get-filename-without-leading-dirs
---


use basename;

`mythtv@cube:/storage/music$ basename "./youtube/Daft Punk - Lose Yourself to `
`Dance.mp3"`
`Daft Punk - Lose Yourself to Dance.mp3`
`mythtv@cube:/storage/music$ basename "./The Cat Empire/Two Shoes/The Cat `
`Empire - 15 - The Wine Song.mp3"`
`The Cat Empire - 15 - The Wine Song.mp3`