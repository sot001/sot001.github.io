---
title: git--troubleshooting
date: '2023-04-01 19:37:56 +0000'
categories:
- git
tags:
- git
---


### branch not set to pull

Running git pull to refresh a branch (region2_uat ) and you're
presented with the following error;

    goronski website_code3 (region2_uat) # git pull
    You asked me to pull without telling me which branch you
    want to merge with, and 'branch.region2_uat.merge' in
    your configuration file does not tell me, either. Please
    specify which branch you want to use on the command line and
    try again (e.g. 'git pull <repository> <refspec>').
    See git-pull(1) for details.

    If you often merge with the same branch, you may want to
    use something like the following in your configuration file:

        [branch "region2_uat"]
        remote = <nickname>
        merge = <remote-ref>

        [remote "<nickname>"]
        url = <url>
        fetch = <refspec>

    See git-config(1) for details.

Check the branch is set to pull from origin;

    goronski website_code3 (region2_uat) # git remote show origin
    * remote origin
      Fetch URL: git@git.server:devops/website_code3.git
      Push  URL: git@git.server:devops/website_code3.git
      HEAD branch (remote HEAD is ambiguous, may be one of the following):
        region2_prj1
        master
      Remote branches:
        region2_prj1               tracked
        region2_uat                tracked
        region1_supp             tracked
        region1_uat              tracked
        master                  tracked
        refs/remotes/origin/UAT stale (use 'git remote prune' to remove)
      Local branches configured for 'git pull':
        region1_uat merges with remote region1_uat
        master     merges with remote master
      Local refs configured for 'git push':
        region2_uat   pushes to region2_uat   (local out of date)
        region1_uat pushes to region1_uat (local out of date)
        master     pushes to master     (local out of date)

Under <b>Local branches configured for 'git pull':</b> you can see that
region2_uat is not configured for 'pull'. to fix that, set the upstream
on the branch;

`goronski website_code3 (region2_uat) # git branch --set-upstream region2_uat origin/region2_uat`

Now if you check the origin, you'll see its configured;

    goronski website_code3 (region2_uat) # git remote show origin
    * remote origin
      Fetch URL: git@git.server:devops/website_code3.git
    ....snip....
      Local branches configured for 'git pull':
        region2_uat   merges with remote region2_uat
        region1_uat merges with remote region1_uat
        master     merges with remote master
    ...snip....

Now you should be able to pull;

    goronski website_code3 (region2_uat) # git pull
    Updating 2ac61da..bff8125
    Fast-forward
     admin.php                        |  Bin 32635 -> 40576 bytes
     includes.php                     |  Bin 95863 -> 98243 bytes
    ....