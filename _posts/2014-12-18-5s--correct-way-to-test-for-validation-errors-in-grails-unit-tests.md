---
layout: post
title: 5s - Correct way to test for validation errors in Grails Unit Tests
categories: [5s, Grails]
tags: [Testing, Errors]
published: true
description: "A snippet to test an object for validation errors in a Grails Unit Test"
date: "2014-12-18"
fivesecond: true 
---

````groovy
domain.clearErrors()

// set your params, mock what you need to mock
// and call the tested method

assert domain.hasErrors()
````

Docs: [`clearErrors`](http://grails.org/doc/2.2.x/ref/Domain%20Classes/clearErrors.html) and [`hasErrors`](http://grails.org/doc/2.2.x/ref/Domain%20Classes/hasErrors.html).

