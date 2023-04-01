---
title: one-line-encrypt-decrypt-files
date: '2023-04-01 19:37:57 +0000'
categories:
- one-line-encrypt-decrypt-files
tags:
- one-line-encrypt-decrypt-files
---


    openssl enc -e -bf-cbc -in <FILE>.tar.gz -out <FILE>.tar.gz.enc
    openssl enc -d -bf-cbc -in <FILE>.tar.gz.enc -out <FILE>.tar.gz

[Category:Security](Category:Security "wikilink")