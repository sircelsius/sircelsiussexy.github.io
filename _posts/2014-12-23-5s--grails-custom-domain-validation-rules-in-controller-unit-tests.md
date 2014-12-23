---
layout: post
title: "5s - Grails: Custom Domain validation rules in Controller Unit Tests"
categories: [5s, Grails]
tags: [Testing, grailsApplication, validation]
published: true
fivesecond: true
date: "2014-12-23"
description: "Snippet - add the grailsApplication object to a Domain instance in a Grails unit test"
---

## Domain

````groovy
class someDomain(){
  String someAttribute

  static constraints = {
    someAttribute(validator: {
      val, obj -> val.matches(obj.grailsApplication.config.validator.someRegexp)
    })
  }
}
````

## Config

````groovy
validator.someRegexp = '^.*(?=.*\\d)(?=.*[a-zA-Z]).*$'
````

## Test class for a controller

````groovy
@TestFor(someController)
@Mock([someDomain, someOtherDomain])
class SomeControllerTests{
  @Before
  void setUp(){
    def someDomainObject = new SomeDomain(someAttribute: "pa55w0rd")
    someDomainObject.save()
  } 
}
````
<p class="description">You'd expect this to work. It doesn't</p>

The above throws a nice `NullPointerException`:

````bash
java.lang.NullPointerException: Cannot get property 'config' on null object
````

This is due to the fact that while the annotations have properly injected the `grailsApplication` Object in the test class, it is only available for the tested class - `SomeController` here - and not for other classes that may be mocked for the tests.

## Solution

You need to manually inject the `grailsApplication` object in your `SomeDomain` objects:

````groovy
@TestFor(someController)
@Mock([someDomain, someOtherDomain])
class SomeControllerTests{
  @Before
  void setUp(){
    def someDomainObject = new SomeDomain(someAttribute: "pa55w0rd")
    someDomainObject.grailsApplication = grailsApplication
    someDomainObject.save()
  } 
}
````
<p class="description">Inject you grailsApplication object in the domain instance</p>

<small>Based on an [answer on stackoverflow](http://stackoverflow.com/questions/13845975/grailsapplication-access-in-grails-unit-test)</small>