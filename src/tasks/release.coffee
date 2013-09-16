#
# grunt-release
# https://github.com/articulate/grunt-release
#
# Copyright (c) 2013 Andrew Nordman
# Licensed under the MIT license.
#

exec = require('child_process').exec
fs = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  grunt.registerMultiTask 'release', 'Release a version of application', ->
    options = @options
      repo: 'articulate/grunt-release'
      remote: 'origin'
      branch: 'master'

    done = @async()

    determineVersion options
    updatePackage options
    generateChangelog options, ->
      versionBump options, (error) ->
        if error?
          done(false)
        else
          done()

  determineVersion = (options) ->
    unless grunt.option('currentVersion')
      version = grunt.file.readJSON('package.json')['version']
      grunt.option('currentVersion', version)

    unless grunt.option('newVersion')
      [major, minor, patch] = grunt.option('currentVersion').split('.')

      if grunt.option('major')?
        major++
      else if grunt.option('minor')
        minor++
      else if grunt.option('patch')
        patch++

      newVersion = "#{major}.#{minor}.#{patch}"
      grunt.option('newVersion', newVersion)

  generateChangelog = (options, callback) ->
    currentVersion  = grunt.option('currentVersion')
    nextVersion     = grunt.option('newVersion')
    range           = "#{currentVersion}...HEAD"

    grunt.log.writeln "Generating CHANGELOG entry for #{nextVersion}..."
    format = '%s|||||%b'
    cmd = "git log #{range} --pretty='#{format}' --reverse --grep='pull request'"

    exec cmd, (error, stdout, stderr) ->
      date = new Date()
      changes = "## Authoring Tools #{nextVersion} (#{date.toDateString()})" + '\n\n'

      for line in stdout.split('\n')
        if line != ''
          [title, description] = line.split "|||||"
          pr_id = title.match(/request #(\d+)/)[1]
          changes += "* [##{pr_id} - #{description}](https://github.com/#{options.repo}/pull/#{pr_id})" + '\r\n'

      fs.readFile './CHANGELOG.md', (error, data) ->
        newLog = changes + '\n' + data
        fs.writeFile './CHANGELOG.md', newLog, (err) ->
          callback(null)

  updatePackage = () ->
    pkg = grunt.config('pkg') || grunt.file.readJSON('package.json')
    grunt.log.writeln "Updating package.json version to #{grunt.option('newVersion')}..."
    pkg.version = grunt.option('newVersion')
    grunt.file.write './package.json', JSON.stringify(pkg, undefined, 2)

  versionBump = (options, callback) ->
    commands = [
      "git add package.json CHANGELOG.md"
      "git commit -m 'Version bump to v#{grunt.option('newVersion')}'"
      "git tag v#{grunt.option('newVersion')}"
      "git push #{options.remote} #{options.branch} --tags"
    ]

    grunt.log.writeln "Committing changes and pushing tag..."

    exec commands.join(" && "), (error, stdout, stderr) ->
      if error
        grunt.log.error stderr
        callback(error)
      else
        callback(null)

