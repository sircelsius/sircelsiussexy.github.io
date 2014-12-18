---
layout: post
title: Grunt and Bower ftw
categories: [About]
tags: [Grunt, Bower, Jekyll, gh-pages]
published: true
date: "2014-12-15"
description: "I switched from a simple jekyll build to a bower and grunt workflow"
d3: true
scripts:
  - bowergrunt.js
---

<p class="message">Over the weekend, I switched from the original jekyll build of the site to a new workflow using <em>bower</em> and <em>grunt</em>.</p>

The original jekyll building process is cool, but it lacks a few things to make it really unforgettable. After playing around a bit with *liquid* tags to add some features to my pages, I thought I might need a bit more flexibility with dependency management and building / deploying.

To achieve that, here are the new features I have added:

  1. No github building of my jekyll. Only the compiled site is available on the repo's `master` branch.
  1. Better dependency management with `bower`.
  1. A new building and serving process using Grunt.
  1. A couple of lesser features that are more the results of my messing around with the code than anything else:
    * Custom, per post scripts using Front Matter declarations. For example, this post includes a script named `bowergrunt.js`.
    * Ability to choose which bower dependencies are injected in a page. This post uses the <span data-d3="1">d3</span> <span data-d3="2">library</span> for example (These insanely well chosen colors are "roboto" and "fedora" from [bada55.io](http://www.bada55.io)).
    * Only posts with the `published: true` property in their Front Matter declaration appear on the homepage. I'm working on a way to completely disable unpublished posts from my building process soon.


I'll be posting a comprehensive tutorial explaining how I got all this to work soon. In the meantime, know that it was largely inspired by the process described by [Aymerick](http://www.aymerick.com) on this [blog post](http://www.aymerick.com/2014/07/22/jekyll-github-pages-bower-bootstrap.html).

Oh yeah, and I messed around with [Bootstrap Material Design](http://fezvrasta.github.io/bootstrap-material-design/) a little. I don't know if I'll keep it or not.