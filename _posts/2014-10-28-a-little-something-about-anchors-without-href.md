---
layout: post
title: A little something about anchors without href
published: True
categories: [HMTL]
tags: [HTML, CSS, a, href, cursor]
---

<p class="message">
	Today, I spent quite some time wondering why an anchor element on my page didn't have the correct cursor property. This quick post explains why.
</p>

## The right way to use `a`

All web developers have already used anchor (`a`) elements without specifying the value of the `href` attribute. Often, we want to have a link that opens a modal box or fires an ajax call. We want it to look like a link but not to trigger a redirection.

Historically, this was possible using either one of the following methods:

```` html
<a href="#">Click me I'm a link</a>
````

```` html
<a href="javascript:void(0)">Click me I'm a link</a>
````

The difference between these two methods being that the latter will not scroll the page whereas the first method will bring you back to the top. See this [fiddle](http://jsfiddle.net/SirCelsius/fpcmkgfL/) for an example.

The HTML5 specification changed that by making the `href` attribute optional. You may now create [placeholder hyperlinks](http://www.w3.org/TR/html-markup/a.html#placeholder-hyperlink) that will be links, but will not trigger a redirection. And you can still do fancy stuff with them if you want to.

## There is a slight problem

If there weren't any problems, things would be too perfect to be true and us lowly devs would end up being useless.

If you create a placehoder link in your website, the `cursor` property will not always be set to `pointer` as it should. As a matter of fact some browsers will style that as a simple text element. See this [fiddle](http://jsfiddle.net/SirCelsius/9vrdq6ca/2/) for an example.

In the end, you're better off using the good old `javascript:void(0)` method!