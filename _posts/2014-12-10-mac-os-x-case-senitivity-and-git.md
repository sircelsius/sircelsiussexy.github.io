---
layout: post
title: Mac OS X case sensitivity and git
published: True
categories: [git]
tags: [Code, git, rage, ignorecase]
---

<p class="message">I love my new macbook. Just about as much as I hate it.</p>

I recently bought a Macbook Pro because I had grown tired of my almost three years old and shitty - because I used it a lot, not because it was in the first place - HP Elitebook. I had been thinking about it for a while and I must say I am qui impressed. It is light and quick but most of all I love the fact that I found a *nix like terminal and general file structure. It feels right at home! I'll still install fedora soon enough because I can, but hey, it's been a week and I still haven't, who would have thought?

There is one thing that made me really mad though: the case insensitivity of the [HFS+ File System](http://en.wikipedia.org/wiki/Hierarchical_File_System). I mean seriously, where the fuck does that come from anyway? Why would anyone want that? The regular users wouldn't notice anything if it were different, and the more advanced users would never have problems similar to what I'll describe below.

<img src="public/img/wtf.jpg" alt="Seriously Apple?">

## The git problem

Sometimes, because of that case insensitivity, versioning systems - meaning git - get messed up pretty badly. 

What happened to me was pretty insanely time consuming and enraging. Let's assume my git repo was in the following state:

  * I had a file named `Foo.jpg` in my project, and I was working on branch `A`. The `Foo.jpg` file was not really my concern as it was an older file I had taken from the `master` branch earlier.
  * My coworker was working on branch `B`. He *deleted* `Foo.jpg` and created a new file in the same location named `foo.jpg`.
  * All my changes on branch `A` were commited, running `git status` showed me no changed files.

However, whenever I tried to run `git checkout B`, the command failed with the following output:

```` bash
error: The following untracked working tree files would be overwritten by checkout:
    foo.bar
Please move or remove them before you can switch branches.
Aborting
````

What this message means is that when git tried to put the `foo.jpg` file from the `B` branch in my file system, it found that the file already existed in the working tree under `Foo.jpg` - because for the OSX File System, they are the same files - although it had not been added to the tracked files - because for git, `Foo.jpg` is not the same thing as `foo.jpg`.

At this point, you're probably thinking something similar to what I thought at the time this first happened to me:

<img src="public/img/wtf2.jpg" alt="I have no idea what's happening">
<p class="description">wtf OSX?</p>

## The non solution

I started derping around on the internets to find out how to solve that problem. I found a [lot](http://stackoverflow.com/questions/4858047/git-error-the-following-untracked-working-tree-files-would-be-overwritten-by-ch) [of](http://stackoverflow.com/a/14283695/3465375) [things](http://stackoverflow.com/a/23960663/3465375) on stackoverflow that try to explain the problem and give different workarounds.

It seems the accepted solution to this known problem is to set the git `ignorecase` option to `true`. Once again, I don't believe this is a *good* solution, or even a *solution*. I don't want my git to ignore case. I don't want it to consider `Foo.jpg` the same as `foo.jpg`. What if one day I decide I want to keep both files?

Another way of working around the problem that I found was to use a combination of `git mv` commands to rename the files letting git know they were changed. While this is a *more acceptable* solution, it doesn't answer my needs. I want this problem to *not happen anymore*.

At the moment I am considering creating a partition on my hard drive to store my git projects - but of course Yosemite makes it hard to shrink the current partition I have in order to create a new one. So much for the out of the box experience. 

I hate my Mac.