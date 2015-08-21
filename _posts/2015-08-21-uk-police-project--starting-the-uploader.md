---
layout: post
title: UK Police Project - Uploader v0.0.1
published: true
date: '2015-08-21'
description: 'Starting a NodeJS API + Angular frontend project' 
categories: [projects, uk_police]
tags: [Code, node, nodejs, mongodb, elasticsearch, express]
---

**All posts regarding the UK Police project can be found [here](/projects/uk_police).**

<p class="message">The CSV uploader submodule of the UK Police Project is a NodeJS script that reads a bunch of files, processes their content and inserts it into a mongoDB database and an Elasticsearch index.</p>

## Introduction

The code is available [on github](github.com/sircelsiussexy/uk-police-csv-elasticsearch-uploader).

This script's entry point is the `src/es-uploader.js` file.

This script calls the following modules:

  1. `src/utils/reader.js`: reads CSV files and outputs their content to a list.
  1. `src/utils/processor.js`: process raw entries into objects that match the required data model.
  1. `src/utils/writer.js`: insert objects into an Elasticsearch index.

## Details

### Command line arguments

*These arguments are parsed using [`commander`]().*

  * `--host` (or `-h`) the host of the Elasticsearch index, defaults to `localhost`.
  * `--port` (or `-p`) the port of the index, defaults to `9200`.
  * `--filename` (or `-f`) the path to the file to process. If no filename is provided, the script will batch process all files within the `resources`directory.

### [WIP] Batch processing

We want to be able to batch upload files. As of version `v0.0.1`, this batch upload will cause Node to run out of memory when trying to upload too many files.