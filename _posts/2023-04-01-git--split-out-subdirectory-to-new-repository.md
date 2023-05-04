---
title: git--split-out-subdirectory-to-new-repository
date: '2023-04-01 19:37:56 +0000'
categories:
- git
tags:
- git
---


Have a subdirectory (website) that i'd like to branch into a new
repository, keeping all history;

    ~/projects/repos
     - all access feed
     - website
     - nagios
     ..

Make current directory the big repo;

    [dev1@goronski projects]$ pushd ~/projects/repos
    ~/projects/repos ~/projects ~/projects ~/projects

Use subtree to split out nagios dir into nagios-only branch

    [dev1@goronski repos]$ git subtree split -P website3 -b website3-only
    Created branch 'website3-only'
    da7e2c49681aa2b5555dd6834f1f815528cf7e92

Remove \~/projects/repos/ from current working dir

    [dev1@goronski repos]$ popd
    ~/projects ~/projects ~/projects

Create the new directory for the repo;

`[dev1@goronski projects]$ mkdir ~/projects/website3`

Make it the current dir;

    [dev1@goronski projects]$ pushd ~/projects/website3
    ~/projects/website3 ~/projects ~/projects ~/projects

Initialise the directory

    [dev1@goronski website]$ git init
    Initialized empty Git repository in /home/dev1/projects/website3/.git/

Pull the branch from the big repo into the current dir;

    [dev1@goronski website3]$ git pull ~/projects/repos website3-only
    remote: Counting objects: 9, done.
    remote: Compressing objects: 100% (6/6), done.
    remote: Total 9 (delta 2), reused 7 (delta 1)
    Unpacking objects: 100% (9/9), done.
    From /home/dev1/projects/repos
     * branch            website3-only   -> FETCH_HEAD

Add the remote origin (from gitlab, after creating the new project);

`[dev1@goronski website3]$ git remote add origin git@git.server:devops/website3.git`

Push it up

    [dev1@goronski website3]$ git push origin -u master
    Counting objects: 9, done.
    Compressing objects: 100% (7/7), done.
    Writing objects: 100% (9/9), 7.54 KiB | 0 bytes/s, done.
    Total 9 (delta 2), reused 0 (delta 0)
    To git@git.server:devops/website.git
     * [new branch]      master -> master
    Branch master set up to track remote branch master from origin.