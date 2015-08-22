---
layout: post
title: UK Police Project - Intro
published: true
date: '2015-08-19'
description: 'Starting a NodeJS API + Angular frontend project' 
categories: [projects, uk_police]
tags: [Code, node, nodejs, csv, data]
---

**All posts regarding the UK Police project can be found [here](/projects/uk_police).**

<p class="message">I recently discovered that the UK Police had an open data project in which they upload a bunch of information on recorded crime activity. I decided to write an application to have fun with this data.</p>

## General idea

While the provided dataset is quite large, it comes in a bunch of `csv` files that in my opinion lack customization. At first I wanted to provide an API that enabled people to download custom files.

For example, I wanted to provide the ability to download a file with information about all the theft related data in London and Manchester between 2014-09 and 2015-02, in JSON.

The idea evolved slightly after that, as I added a bunch of possibilities including supervised learning on the crime outcome, a map and timeline display of crime history and other cool things.

## Final requirements

### API

Provide an open API with the following endpoints:

  1. `/data`: enable download of custom files via POST request parameters within the following:
    * `file_format`: **required** either `csv` or `json`.
    * `start_date`: **required** in the form `MM-YYYY`.
    * `end_date`: in the form `MM-YYYY` if `null` return data only for the start month.
    * `location`: a JSON object in the form `{ lat: 3.11, lon: 3.11}`.
    * `range`: **required if `location` isn't null** the distance in `km` around the given center to query for.
    * `location_name`: the name of a given police center.
    * `crime_type`: the crime type to restrict to.
    * `outcome`: the outcome to restrict to.
  2. `/predict`: given a number of parameters such as date, location, crime type, etc, run a machine learning algorithm to predict a value based on the existing ones.

### Frontend

Create the following views:

  * `map`: a map showing crimes. This map should be customizable on all the crime parameters.
  * `timeline`: a timeline showing crime information & statistics per month. This timeline should be customizable as well.
  * Secondary views such as API documentation, project presentation and so on.

I started this project a few days ago so it is barely starting, I will try to write detailed posts about the different things I do as I work on it.