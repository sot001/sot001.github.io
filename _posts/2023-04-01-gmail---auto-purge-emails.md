---
title: gmail---auto-purge-emails
date: '2023-04-01 19:37:56 +0000'
categories:
- gmail---auto-purge-emails
tags:
- gmail---auto-purge-emails
---


there is a script
[here](https://drive.google.com/open?id=1MWPZkmAXgQuKCF_XuBndxrl12R02L9UAWwifDZVVStsODxNNVIqHq1G-&authuser=0)
that will autodelete messages older than 30 days from a specific folder
in gmail. Modify the details and rerun to adjust retention rate

[reference](http://www.labnol.org/internet/gmail-auto-purge/27605/)

    Here’s how you can get auto-purge to work inside your Gmail:

    Set the value of GMAIL_LABEL to the label that you wish to auto-purge and PURGE_AFTER are the number of days for which you to retain a message in Gmail.
    Go to Run -> Initialize and grant the necessary permissions. This is your personal script and nobody else will ever have access to your data.
    Go to Run -> Install to install the auto-purge script.
    Awesome Google Scripts → Custom Google Scripts →

    That’s it. Exit the Google Script and it will continuously monitor that particular Gmail label in the background.
    If you need to disable auto-purging later, just open the same script in your Google Drive and choose Run -> Uninstall.