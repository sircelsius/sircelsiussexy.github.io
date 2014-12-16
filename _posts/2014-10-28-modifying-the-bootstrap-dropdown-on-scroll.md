---
layout: post
title: Modifying the Bootstrap dropdown on scroll
published: true
categories: [Tutorial, Bootstrap]
tags: [HTML, CSS, JS, Bootstrap]
date: "2014-10-28"
description: "Make the Bootstrap dropdown change it's opening direction on scroll"
---

<p class="message">
	I recently answered a <a href="http://stackoverflow.com/a/26590613/3465375">Stackoverflow question</a> about getting a dropdown menu to change the direction in which it opens depending on its position in the window. Here's a little explanation about how I got things to work.
</p>

## Problem overview

The idea here is to get the Bootstrap [dropdown](http://getbootstrap.com/components/#dropdowns) component to have a more user friendly way of opening when it is displayed at the bottom of a page. If the dropdown is in the lower part of the page, it is a bit painful for the user to have to scroll down to see the menu items.

<iframe width="100%" height="300" src="http://jsfiddle.net/SirCelsius/2uyh4j3w/12/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>
<p class="description">This is not cool, Bootstrap!</p>

The person who asked the question wanted to be able to change the way the dropdown opens depending on its position in the window. If the dropdown wa below the vertical center of the window, it had to be opened upwards, otherwise downwards.

## Final result

I made two iterations of the dropdown: the first changes dynamically when the user scrolls:

<iframe width="100%" height="300" src="http://jsfiddle.net/SirCelsius/2uyh4j3w/10/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>
<p class="description">The magic happens when scrolling</p>

The second - which I personally find less intrusive for the user - does not change states while it is open, but calculates it's most efficient state before opening:

<iframe width="100%" height="300" src="http://jsfiddle.net/SirCelsius/2uyh4j3w/11/embedded/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>
<p class="description">The magic opens when opening the dropdown</p>

## Explanation

Both answers calculate a value that I named `relativeOffset` which is the offset between the top of the window - not the top of the page - and the dropdown toggle. By comparing this to the window height, we can know whether the dropdown is in the upper or lower part of what's visible in the window.

All we have to do is listen to the right event - `$(window).scroll` for the first solution, `$('.dropdown-toggle').click` for the second - and toggle the `reverse` style if we want to.

Here's the code for the `reverse` class:

```` css
.reverse{
	top:auto;
	bottom:100%;
}
````

And here's the javascript for the second iteration:

```` javascript
$(".dropdown-toggle").click(function(){
    // get the scollTop (distance scrolled from top)
    var scrollTop = $(window).scrollTop();
    // get the top offset of the dropdown (distance from top of the page)
    var topOffset = $(".dropdown").offset().top;
    // calculate the dropdown offset relative to window position
    var relativeOffset = topOffset-scrollTop;
    // get the window height
    var windowHeight = $(window).height();
    
    // if the relative offset is greater than half the window height,
    // reverse the dropdown.
    if(relativeOffset > windowHeight/2){
        $(".dropdown-menu").addClass("reverse");
    }
    else{
        $(".dropdown-menu").removeClass("reverse");
    }
});
````