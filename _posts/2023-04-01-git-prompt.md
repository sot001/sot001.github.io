---
title: git-prompt
date: '2023-04-01 19:37:56 +0000'
categories:
- git-prompt
tags:
- git-prompt
---


    # I wanted a dead simple reminder if I'm in a git managed directory
    # This takes the standard ubuntu $PS1 and adds (branch-name) in "default" terminal colour just before your $ / #
    #
    # the correct way on centos is to add it to something like /etc/sysconfig/bash-prompt-{xterm,default,screen}
    # I can't be arsenaled...  -davidATstarkers.org
    #
    # centos6:       add to /etc/bashrc
    # ubuntu14/mint: add to /etc/bash.bashrc

    # vim:ts=2:sw=2


    simple_gitprompt(){
      #update titles on terminals (putty/terminator etc..)
      [["${TERM}"_!=_'linux'|"${TERM}" != 'linux']] && printf "\033]0;%s\007" "$HOSTNAME:$PWD"

      # Only run this if we are within a git directory
      git_status="$(git status --short --untracked=normal 2>/dev/null)"
      if [ X$? == X0 ]; then

          gitsym="$(git symbolic-ref HEAD)"
          branch="${gitsym##refs/heads/}"

          if ((UID != 0)); then
            export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[00m\]($branch)\[\033[01;34m\] \$\[\033[00m\] '  # no root, git
          else
            export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \[\033[00m\]($branch)\[\033[01;34m\] \$\[\033[00m\] '  # root, git
          fi
        else
          if ((UID != 0)); then
            export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '  # no root, no git
          else
            export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '   # root, no git
          fi
      fi
    }
    #only run if interactive shell
    if [ "$PS1" ] ; then
      PROMPT_COMMAND='simple_gitprompt'
    fi