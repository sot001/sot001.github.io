---
title: gcp---ssh-via-iap
date: '2023-04-01 19:37:56 +0000'
categories:
- gcp---ssh-via-iap
tags:
- gcp---ssh-via-iap
---


## Tunnelling

Ensure your pub key is uploaded to GCP

`gcloud compute os-login ssh-keys add --key-file=`<path_to_public_key>

In one window, create the tunnel

`gcloud beta compute start-iap-tunnel `<remote server>` 22 --local-host-port=localhost:2222 --project `<project>

In another terminal;

` ssh localhost -p 2222 -A -i `<path_to_private_key>

## Direct over IAP tunnel

`gcloud compute ssh `<remoteserver>` --project `<project>` --zone=`<zone>` --tunnel-through-iap --strict-host-key-checking=no`