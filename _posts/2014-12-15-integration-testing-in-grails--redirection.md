---
layout: post 
title: Integration Testing in Grails - Redirection
categories: [Code, Grails]
tags: [Integration, Testing, Redirection, Grails]
published: True
date: "2014-12-15"
description: "Integration testing redirections in grails"
---

<p class="message">It might just be me, but it seems to me that there aren't that many docs out there regarding testing in grails. And even when there are, they tend to be very confusing regarding the differences between <em>integration</em> and <em>unit</em> testing. That being said, here's a little something about testing redirection.</p>

## Basic redirection

When the action you are testing is similar to the following:

```` groovy
def someAction(){
  // ...
  redirect(action: "someOtherAction")
}
````

Testing the redirection is dead simple:

````groovy

