---
layout: post
title: Unit Test in Grails - A few notes
categories: [Code, Grails]
tags: [Unit, Testing]
published: false
date: "2014-12-16"
description: "Grails Unit Tests snippets and best practices"
---

<p class="message">The general opinion seems to be that unit tests in grails aren't as useful as integration tests. I respectfully disagree. <em>Unit tests</em> are a totally different thing from <em>integration tests</em>, both being equally important.</p>

## Quick reminder

Let me just state as clearly as I can the conceptual differences between unit and integration tests. Too often on the Internet, there are people who are not perfectly clear whether they are writing tests of one type or the other. This lead to a lot of confusion.

Let's assume you want to test the following method:

```` groovy
def someMethod(){
  if(someOtherMethod(params.id)){
    return true
  }
  else{
    return false
  }
}
````

### Unit tests verifiy that a method works assuming all the rest of your code does

When you write a **unit** test, you want to test a small chunk of code, considering that the rest of the world is full of butterflies and unicorns - meaning everything else works perfectly as expected.

When testing our `someMethod()` method, we will *force* the `someOtherMethod()` method to return whatever we want depending on the test case.

The cool thing is that if this test fails, we will know that it is not because the `someOtherMethod()` method did not work as expected, but because what the `someMethod` does *in itself* is broken.

This implies that when a unit test fails, you know immediatly that the method tested isn't working as intended.

### Integration tests verifiy that a method's functionnality follows a use case scenario

## Mocking

Often, I am tempted to mock my services once at the beginning of a test case and not wonder about them afterwards.

```` groovy
def someServiceMock = mockFor(SomeService)

someServiceMock.demand.someServiceMethod {
  Map params -> return true
}

controller.someService = someServiceMock.createMock()

// never worry about someService.someServiceMethod anymore
// just write some tests case
````
<p class="description">This is all very nice and might seems like a good way to save time and not write redundent code. I personally dislike it.</p>

