---
title: sending-file-attachments-from-command-line
date: '2023-04-01 19:37:58 +0000'
categories:
- sending-file-attachments-from-command-line
tags:
- sending-file-attachments-from-command-line
---


use mutt;

`echo "This is the body of the email" | mutt -a the_attachment.file -s "the subject of the email" the.recipient@a.mailaddress`