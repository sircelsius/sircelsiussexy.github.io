---
layout: post
title: A combination of cool Grunt tasks
categories: [About]
tags: [Jekyll, Grunt]
published: false
date: "2014-12-22"
description: "Adding cssmin, htmlmin and uncss to my Jekyll website"
---

<p class="message">Last week, I added Grunt building to this website. Today, I changed the building workflow to add a few improvements to resource management.</p>

## The old, slow, unoptimized workflow

Maybe you remember back in the days - I know, that was in late october, so it wasn't a long ago - I wrote an article explaining how to use Front Matter to merge the lanyon CSS files with your own. That was, as I said earlier, a workaround that wasn't very optimal. It did lower the number of requests to get the stylesheets, but it didn't minimize them or remove any unused rules.

At the time the building workflow was the following:

  * There was a main css file named `aliconnors.css` that included the other files using Front Matter and Liquid tags:
  
  ````css
  ---
  layout:
  ---
  {% raw %}
  {% include {{ site.baseurl }}public/css/poole.css %}
  {% endraw %}
  // my custom rules
  ````
  

  * Upon building, Jekyll automatically included the correct files and created a unique stylesheet.

While this is all very nice, it didn't please me for the following reasons:

  * The file wasn't minimized
  * If I were to add other external resources, I'd end up with a gigantic file that I'd serve on all my pages.

