---
layout: post
title: Merging Lanyon's stylesheets with your own
published: True
categories: [Code]
tags: [jekyll]
date: "2014-10-29"
description: "Customize your Lanyon styles and merge the files into one"
---


<p class="message">
	<a href="http://twitter.com/mdo">mdo</a>'s Lanyon theme for Jekyll is pretty swell. It has a good design and is dead simple to use.
	I recently wanted to add a bit of custom styling and merge my new stylesheet with the existing ones. Here's how I did that.
</p>

## Lanyon's existing style

Out of the box, Lanyon provides three different stylesheets:

  * `poole.css`
  * `syntax.css`
  * `lanyon.css`

These contain the different styles for headers, code blocks, sidebars and the likes, and are included in the `_includes/head.html` file in the following order:

```` html
<link rel="stylesheet" href="{{ site.baseurl }}public/css/poole.css">
<link rel="stylesheet" href="{{ site.baseurl }}public/css/syntax.css">
<link rel="stylesheet" href="{{ site.baseurl }}public/css/lanyon.css">
````

## What I changed

What I wanted to do was merge all the files in one single `aliconnors.css` file (to reduce the number of http requests while being able to keep the original files).

Although the right way to go would be to use a css minifier, I intend to change my workflow soon to use Sass, so I didn't want to change things too much.

I ended up creating a CSS file which contains my custom rules and includes the original CSS using Front Matter:

```` css
---
layout: nil
---
{% raw %}
{% include {{ site.baseurl }}public/css/poole.css %}
{% include {{ site.baseurl }}public/css/syntax.css %}
{% include {{ site.baseurl }}public/css/lanyon.css %}
{% endraw %}

// below are my custom rules

/*Center post images horizontally */
.post img{
	margin-left:auto;
	margin-right:auto;
}

/* Center .description and color them in dark grey */
.post .description{
	text-align:center;
	color:#9a9a9a;
}
````
<p class="description">Front Matter includes in my CSS</p>

This merges all four files into one. After that, I simply updated my `head.html` to include the correct file.

```` html
<link rel="stylesheet" href="{{ site.baseurl }}public/css/aliconnors.css">
````

## What's next?

I'll be doing bigger, more radical changes on my workflow soon. I'll try to post explanations for them here.


### Bonus

I escaped the `liquid` tags in the code samples above using the `raw` and `endraw` tags, as described in  [this stackoverflow answer](http://stackoverflow.com/a/5866429/3465375).