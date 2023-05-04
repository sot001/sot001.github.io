---
title: git--helpful-commands
date: '2023-04-01 19:37:56 +0000'
categories:
- git
tags:
- git
---

### help

`git help <command>`

### Initialising Git

`git config --global user.name "Kristian"`
`git config --global user.email "kristian@email.com"`
`git config --global core.editor vim`
`git config --global merge.tool vimdiff`

### listing config

`git config --list`

### creating new repository

`git init`

### adding files

`git add *`

### committing changes to files

`git commit -m"edit" nagios.cfg`

its important to not that after committing changes, you still need to
push it back to the server

** ProTip** use _sudo nagios -v \~nagios/etc/nagios.cfg && sudo
/etc/init.d/nagios reload_ to check and reload nagios all in the one
command

### push back to master (use other branch name if not pushing to master)

`git push -u origin master`

### get status of remote
```
    git remote show origin
    * remote origin
      Fetch URL: git@git.server:dba/project.git
      Push  URL: git@git.server:dba/project.git
      HEAD branch (remote HEAD is ambiguous, may be one of the following):
        project_prj1
        master
      Remote branches:
        project_prj1               tracked
        project_uat                tracked
        project_supp             tracked
        project_uat              tracked
        master                  tracked
        refs/remotes/origin/UAT stale (use 'git remote prune' to remove)
      Local branches configured for 'git pull':
        project_prj1   merges with remote project_prj1
        project_uat    merges with remote project_uat
        project_supp merges with remote project_supp
        project_uat  merges with remote projecta_uat
        master      merges with remote master
      Local refs configured for 'git push':
        project_prj1   pushes to project_prj1   (up to date)
        project_uat    pushes to project_uat    (up to date)
        project2_supp pushes to project2_supp (up to date)
        project2_uat  pushes to project2_uat  (up to date)
        master      pushes to master      (up to date)
```
### change remote url
```
    # old url
    git remote -v
      origin    git@bitbucket.org:kjsdev/kubernetes.git (fetch)
      origin    git@bitbucket.org:kjsdev/kubernetes.git (push)

    # set new url
    git remote set-url origin git@bitbucket.org:kjsprod/kubernetes.git

    # verify
    git remote -v
      origin    git@bitbucket.org:musodev/kubernetes.git (fetch)
      origin    git@bitbucket.org:musodev/kubernetes.git (push)
```
### get status on local branches
```
    git branch -v
      20150226    be75a50 test for git
      project_prj1   5ce281f Merge branch 'project2_uat'
    * project_uat    bff8125 patch BTS20150414 v2
      project2_supp 8f14e3d patch BTS20150325
      project2_uat  bff8125 patch BTS20150414 v2
      master      5ce281f Merge branch 'project2_uat'
```
### reverting back to a named commit

If you need to revert back to a previous commit, find the hash of the
commit from git log;
```
`git log`
`commit a7e243693f0607311c0f2c4fb1ecde2e6c2d2097`
`Author: developer 1<dev1@email.com>`
`Date:   Mon Aug 3 12:16:45 2015 +0100`

`    Emergency patch`
```
Then pass that hash in;

  - This will destroy any local modifications.
  - Don't do it if you have uncommitted work you want to keep.
  - reset it hard, reset the HEAD, commit then push it back to origin



```

goronski website_code (project2_supp) # git reset --hard a7e243693f0607311c0f2c4fb1ecde2e6c2d2097
HEAD is now at a7e2436 BTS20150609
goronski website_code (project2_supp) # git reset --soft HEAD@{1}
goronski website_code (project2_supp) # git commit -m"rolled back to patch BTS20150609"
goronski website_code (project2_supp) # git push
```

Alternatively, if there's work to keep:
```
    git stash
    git reset --hard 0d1d7fc32
    git stash pop
```
  - This saves the modifications, then reapplies that patch after
    resetting.
  - You could get merge conflicts, if you've modified things which were
  - changed since the commit you reset to.

### revert changes made to local copy

If you want to revert changes made to your working copy, do this:

`git checkout .`

### discarding all local commits not pushed back to master

If you want to revert changes made to the index (i.e., that you have
added), do this:

`git reset`

*' Warning this will reset all of your unpushed commits to master\!*'

If the above complains about merge errors, smash it by fetching the
origin code then hard resetting to origin's version

`git fetch origin`
`git reset --hard origin/project2_uat`

### revert last commited change

If you want to revert a change that you have committed, do this:

`git revert ...`

### remove untracked files

If you want to remove untracked files (e.g., new files, generated
files):

`git clean -f `

Or untracked directories:

`git clean -d`

### git stash

`git stash`

this 'stashes' your changes so you can rebase or whatever and not lose
your changes. afterwards, you'll need to reapply them (if you wish)
via...

`git stash apply`

To get a list of your stashed stuff try:

`git stash list`

To show the code difference from a specific one in the index (EG: 0)
(see list above)

`git stash show -p stash@{0}`

to roll back all:

`git stash show -p | git apply -R`

and if you're happy that you've applied the desired code you can then
delete them from the list

`git stash drop stash@{0}`

You can create cool aliased command to un-apply all stashed code also:

`git config --global alias.stash-unapply '!git stash show -p | git apply -R'`

Now if you run "git apply" but are unhappy with it.. simply run:

`git stash-unapply`

More protips:[ https://git-scm.com/book/en/v1/Git-Tools-Stashing]( https://git-scm.com/book/en/v1/Git-Tools-Stashing)
