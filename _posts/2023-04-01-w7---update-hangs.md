---
title: w7---update-hangs
date: '2023-04-01 19:37:58 +0000'
categories:
- w7---update-hangs
tags:
- w7---update-hangs
---


    1. Disable Windows Updates (tell it to never check for updates).
    2. Reboot.
    3. Download and install Internet Explorer 11.
    4. Download update KB3102810 and place it on your desktop (make sure you get the correct one, 64 bit or 32 (X86) bit). Place on your desktop.
    5. Reboot.
    6. Go into Computer Management (right click on Computer in Start Menu) and select Services.
    7. Stop Windows Update service.
    8. Start Menu, Computer, C: drive, Windows, delete the entire Software Distribution folder.
    9. Double click on update KB3102810 and let it install.
    10: Reboot (this will turn update service back on).
    11. Go into Windows Updates and check for updates. Give it about an hour, it may take less time but be patient. It will start working.
    12. After installing your updates, you can turn Windows Update automatic check for updates back on if you like.