---
title: gcp---log-query
date: '2023-04-01 19:37:56 +0000'
categories:
- gcp---log-query
tags:
- gcp---log-query
---


To clip out just the MESSAGE format of the logs, use jq

`gcloud logging read "logName=projects/losers-dev-1/logs/kubelet" --limit 10 --format json | jq '.[].jsonPayload.MESSAGE`