---
title: jobs-stuck-in-queue
date: '2023-04-01 19:37:56 +0000'
categories:
- jobs-stuck-in-queue
tags:
- jobs-stuck-in-queue
---


check the hostname in the jobqueue table;

    select * from jobqueue;

Some may have the shortened version of the hostname or a different
version that which works. check the ones that have a completed status
(272) and adjust accordingly