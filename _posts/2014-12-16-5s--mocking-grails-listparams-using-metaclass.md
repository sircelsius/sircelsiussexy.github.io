---
layout: post
title: "5s - mocking Grails' list(params){...} using metaClass"
categories: [5s, Grails]
tags: [Testing, Mock]
published: true
fivesecond: true
date: "2014-12-16"
description: "Snippet - Mock a domain's createCriteria().list(params){} method"

---

````groovy
Domain.metaClass.static.createCriteria = {
  [
    list: {
      Object params, Closure cls -> return [domain1, domain2] 
    }
  ]
}
````

<small>Source and explanation on [stackoverflow](http://stackoverflow.com/a/11725359/3465375).</small>