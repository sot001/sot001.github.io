---
title: git--branching
date: '2023-04-01 19:37:56 +0000'
categories:
- git--branching
tags:
- git--branching
---


### branching

`git branch `<new branch name>

this will create a local copy of the master and keep it separate from
master. All commits will then be made against this branch.

### switching branches

`git checkout `<alternate branch>

this will swap to the branch named, so commits will be made here

### merging branched back into master

merge region1_uat branch back into master

`git checkout master`
`git merge region1_uat`

### merging specific commit from a branch back into master

If you have committed several changes into a branch, but only want to
merge up to a certain point into master, use the commit id with the
merge command;

git log uat

    $ git checkout uat
    $ git log
    ...

    commit dbcbd2cc9c849ddcfc10a3e12137e04eb3cb6674
    Author: developer
    Date:   Tue Dec 29 12:23:48 2015 +0000

        patch 20151217

    commit 687617e649c8c28a31db61131eb8b10c45296eda
    Author: developer
    Date:   Tue Dec 29 12:11:11 2015 +0000

        patch 20151217

    commit 5c5d860d51d3ab847a41af0af21b6d6371ba8029
    Author: developer
    Date:   Wed Dec 16 15:39:04 2015 +0000

        patch 20151210

    commit 335d91d6a4e6c80e5f2d6842ac8caf6eeebb4c4f
    Merge: 66a14d5 30e65b1
    Author: developer
    Date:   Thu Dec 3 11:56:21 2015 +0000

We want to merge up to the 'patch 20151210' release so we provide that
commit id to the merge command

    $ git checkout master
    $ git merge 5c5d860d51d3ab847a41af0af21b6d6371ba8029
    $ git log
    ....
    commit 5c5d860d51d3ab847a41af0af21b6d6371ba8029
    Author: developer
    Date:   Wed Dec 16 15:39:04 2015 +0000

        patch 20151210

    commit 335d91d6a4e6c80e5f2d6842ac8caf6eeebb4c4f
    Merge: 66a14d5 30e65b1
    Author: developer
    Date:   Thu Dec 3 11:56:21 2015 +0000

        Merge branch 'uat' of git:dev/project1 into uat

### removing branch

`git branch -d region2_supp`
`Deleted branch region2_supp (was 4ba63b2)`

remove remote branch

`git push origin --delete region2_supp`
`To git@git.server:devops/website_code.git`
`- [deleted]         region1_supp`

### git rebase

`git rebase master`

this will update your local branch with any changes made to master. If
there are files you've changed that conflict, it will complain and ask
you to stash them...

### git rebasing from another branch

checkout the branch that is behind;

`git checkout region2_uat`

now rebase against the one you want to keep

`git rebase region1_uat`