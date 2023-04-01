---
title: terminator-config
date: '2023-04-01 19:37:58 +0000'
categories:
- terminator-config
tags:
- terminator-config
---


\~/.config/terminator/config

    [global_config]
      enabled_plugins = LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
      window_state = maximise
      borderless = True
    [keybindings]
    [profiles]
      [[default|default]]
        use_system_font = False
        background_darkness = 0.37
        background_image = /usr/share/backgrounds/default_1920x1200.png
        scroll_background = False
        font = Courier 10 Pitch 12
        background_color = "#300a24"
        foreground_color = "#ffffff"
        scrollback_infinite = True
      [[remote|remote]]
        use_system_font = False
        foreground_color = "#ffffff"
        scrollback_infinite = True
        font = Courier 10 Pitch 12
        background_color = "#300a24"
        use_theme_colors = True
      [[system|system]]
        use_theme_colors = True
    [layouts]
      [[default|default]]
        [[[child1|[child1]]]
          type = Terminal
          parent = window0
          profile = default
        [[[window0|[window0]]]
          type = Window
          parent = ""
    [plugins]