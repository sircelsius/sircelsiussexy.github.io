---
layout: post
title: UK Police Project - Technologies
published: true
date: '2015-08-20'
description: 'Starting a NodeJS API + Angular frontend project' 
categories: [projects, uk_police]
tags: [Code, node, nodejs, mongodb, elasticsearch, express]
---

**All posts regarding the UK Police project can be found [here](/projects/uk_police).**

<p class="message">I just started working on a new project centered around the UK Police open data. This post details what technologies and libraries / frameworks I will use for this project.</p>

The stack I will use for this is commonly referred to as the MEAN stack as it is centered around mongoDB, ExpressJS, Angular and NodeJS.

## Backend / API

The backend and API parts of the application will be a [`NodeJS`]() application that speaks to two persistence clients:
  * A [`mongoDB`]() database.
  * An [`Elasticsearch`]() cluster.

As the API will never write with these clients, connections to them should be read-only.

## Frontend

The frontend will be a simple [`Angular`]() application that calls the API.

Amongst other libraries, it will use:

  * [`leaflet`]() for maps.

## CSV Uploader

The initial CSV files downloaded from the [UP Police]() website will need to be parsed and inserted in the persistence clients.

This CSV uploader module will be a [`NodeJS`]() script with the following dependencies:

  * [`fast-csv`]() to read the files.
  * [`q`]() to process them asynchronously.
  * [`mongoose`]() to insert in mongoDB.
  * [`elasticsearch`]() to insert in Elasticsearch.

## Others

### Testing

Unit test of JS files will be done with [`Jasmine`]().

End-to-end testing will be done with [`CasperJS`]().

### Logging

All backend projects (at the moment this is written, that is the API and the CSV uploader) will log their output to files using [`winston`]().