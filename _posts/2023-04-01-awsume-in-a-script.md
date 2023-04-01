---
title: awsume-in-a-script
date: '2023-04-01 19:37:55 +0000'
categories:
- awsume-in-a-script
tags:
- awsume-in-a-script
---


When using [awsume](https://awsu.me/) within a launcher shell script,
export the statements (via the -s switch) to a variable then execute
that to set the session

    for profile in dev uat live; do
      SETPROFILE=$(awsume -s $profile)
      $SETPROFILE
      python my-aws-script.py
    done