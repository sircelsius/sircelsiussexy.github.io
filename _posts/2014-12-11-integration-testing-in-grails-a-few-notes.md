---
layout: post
title: Integration Testing in Grails - A few notes
categories: [Code, Grails]
tags: [Integration, Testing]
published: True
---

<p class="message">Writing integration tests is sometimes pretty repetitive, especially if you have many domains that have custom CRUD methods. Here are a few snippets that I have found useful when creating <em>integration tests</em>.</p>

*These snippets will evolve with time, as I write more and more tests.*

## Lists

### size

This requires a bit of logic to understand, but the idea is to verify that the list size is the minimum between the maximum size (set in `params` or as a default value) and the total number of domain objects *minus* the offset parameter (if it exists).

```` groovy
assert controller.modelAndView.model.domainList.size() == Math.min(Domain.count() - (controller.params.offset? controller.params.offset : 0), controller.params.max? controller.params.max : 10)
````
<p class="description">Verify the list size, no matter what the offset or max, no matter what the number of domain objects</p>

### id sorting

```` groovy
// Check that the list is sorted by id if it isn't empty
// This all seems a bit complicated but it is necessary as it is totally
// independant of the number of Domain that currently exist
def id = 1
def domain = null
if(controller.modelAndView.model.domainList.size() > 0){
  for(int i = 1; i <= controller.modelAndView.model.domainList.size(); i++){
    //  Setting the id of the Domain to get
    id = i + (controller.params.offset? controller.params.offset : 0)
    // Getting the domain, failing if it doesn't exist
    domain = Domain.get(id)
    if(!domain){
      fail "Invalid domain object"
    }
    assert controller.modelAndView.model.domainList.get(i-1) == domain
  }
}
````
<p class="description">This also works whatever the offset, max or number of domain objects. How cool is that?</p>

This might seem a bit overkill upon reading it for the first time, but as it turns out, when testing large applications that have many dependencies between their different domains, with tests for domain `A` calling CRUD methods on domain `B` objects, being able to test domain `B` without knowing the *actual* number of objects that exist is paramount. There's nothing more annoying than writing a test that does something like the following and having to refactor it every day because some other test has added or removed objects:

````groovy
assert controller.modelAndView.model.domainList.get(0) == Domain.get(42)
````
<p class="description">The meh test case that is sure to break</p>

## i18n messages

>This assumes that your messages are present in your `message_fr.properties`. It doesn't have to be french though, I'll allow it.

The testing process is separated in two parts: **setting the request locale** so that the tested method knows which message it should get, and **testing the returned message** to make sure that the method gets the correct value.

### Setting the request locale

>Setting the locale can be done either globally for the entire test class or locally for a single method. Although I generally try to set my parameters locally, messages aren't *that* important, so I go with the first option

```` groovy
// the messageSource service needs to be injected
def messageSource

void setUp(){
  controller.request.addPreferredLocale(new Locale("fr"))
}
````
<p class="description">Set the request locale for the whole test class. Easy.</p>

### Testing the returned messages

Supposing you are testing a controller that render an i18n message in `flash.message`, you can test the message value the following way:

```` groovy
assert controller.flash.message == messageSource.getMessage("your.message.label", [your, message, args] as Object[], controller.request.getLocale())
````
<p class="description">Get a message in an integration test class</p>

Let's cut that line in smaller pieces so as to better understand it.

We are calling the `org.springframework.context.messageSource.getMessage(String code, Object[] args, Locale locale)` (javadoc [here](http://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/context/MessageSource.html#getMessage-java.lang.String-java.lang.Object:A-java.util.Locale-)) method. The docs are pretty clear as to what this method does:

> Try to resolve the message. Treat as an error if the message can't be found.

<p class="description">Ok Spring, I get it.</p>

The arguments we are passing to this method are the following:

  1. Your message's code. *Meh*
  2. Your message arguments, `as Object[]`. The casting is important here, or else you'll get nasty `groovy.lang.MissingMethodException` messages when running your tests, and they will fail. If the message you are testing doesn't take any argument, just go full badass style and set that to `null`.
  3. Your `controller.request`'s `Locale` which we set earlier. Just like for the arguments, if you feel like testing the default `Locale`, set this to `null`.

This pretty cool snippet was originally given as an [answer](http://stackoverflow.com/a/27190531/3465375) to one of my questions on stackoverflow. I have been using it ever since. Very love. Many useful. Wow. 