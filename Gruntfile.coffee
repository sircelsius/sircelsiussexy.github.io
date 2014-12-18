#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"

  grunt.initConfig

    copy:
      jquery:
        files: [{
          expand: true
          cwd: "bower_components/jquery/dist/"
          src: "jquery.min.js"
          dest: "vendor/js/"
        }]
      bootstrapmaterial:
        files: [{
          expand: true
          cwd: "bower_components/bootstrap-material-design/dist/css/"
          src: "material.css"
          dest: "vendor/css/"
        },
        {
          expand: true
          cwd: "bower_components/bootstrap-material-design/dist/css/"
          src: "material.css.map"
          dest: "vendor/css/"
        },
        {
          expand: true
          cwd: "bower_components/bootstrap-material-design/dist/js/"
          src: "material.js"
          dest: "vendor/js/"
        }]
      d3:
        files: [{
          expand: true
          cwd: "bower_components/d3/"
          src: "d3.min.js"
          dest: "vendor/js"
        }]

    cssmin:
      combine:
        files:
          "public/css/aliconnors.min.css" : [
            "public/css/lanyon.css",
            "public/css/poole.css",
            "vendor/css/*.css"
            "public/css/aliconnors.css"
          ]

    clean: ["public/css/aliconnors.min.css", "vendor/css/*.css"]    

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "public/css/**/*"
          "public/js/**/*"
          "_config.yml"
          "*.html"
          "*.md"
        ]
        tasks: [
          "exec:jekyll"
          "htmlmin"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

    htmlmin:
      dist:
        options:
          removeComments: true,
          collapseWhitespace: true
        files: [{
          expand: true,
          cwd: "_site",
          src: "**/*.html",
          dest: "_site"
        }]

  grunt.registerTask "build", [
    "clean"
    "copy"
    "cssmin"
    "exec:jekyll"
    "htmlmin"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]