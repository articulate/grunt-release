#
# grunt-release
# https://github.com/articulate/grunt-release
#
# Copyright (c) 2013 Andrew Nordman
# Licensed under the MIT license.
#

module.exports = (grunt) ->
  grunt.initConfig
    jshint:
      all: [
        'tasks/*.js'
        '<%= nodeunit.tests  %>'
      ]
      options:
        jshintrc: '.jshintrc'

    clean:
      tests: [ 'tmp' ]

    nodeunit:
      tests: ['test/*_test.js']

    coffee:
      src:
        expand: true
        flatten: false
        cwd: 'src'
        src: '**/*.coffee'
        dest: '.'
        ext: '.js'

    release:
      github:
        options:
          repo: 'articulate/grunt-release'
    

  grunt.loadTasks 'tasks'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'test',    ['clean', 'release', 'nodeunit']
  grunt.registerTask 'default', ['jshint', 'test']
