# grunt-release

> Manage version releases of your libraries/applications

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-release --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-release');
```

## The "release" task


Release handles version management of your library or application via GruntJS. It is configured to
do the following things:

  1. Update package.json with new version number
  2. Generate a CHANGELOG entry for the new version (using GitHub PRs merged since last version)
  3. Commit the package.json and CHANGELOG changes
  4. Tag the new commit as the new version
  5. Push the commit and the tags to your repository

Configuration options are in place for where to push to, including remote name and branch.

In your project's Gruntfile, add a section named `release` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  release: {
    options: {
      repo: 'articulate/grunt-release',
      remote: 'origin',
      branch: 'master'

    },
  },
})
```

### Options

#### options.repo
Type: `String`
Default value: `'articulate/grunt-release'`

The location of the GitHub repo that your code is stored at.  This is used for linking commits/PRs

#### options.remote
Type: `String`
Default value: `'origin'`

The name of your remote  that you want updated with tagged versions.

#### options.branch
Type: `String`
Default value: `'master'`

The branch you want to cut releases from.


### Usage Examples

#### Default Options
In this example, the default options are used to do something with whatever. So if you wanted to create releases for `github/hubot`, you would configure like this:

```js
grunt.initConfig({
  release: {
    github: {
      options: {
        repo: 'github/hubot'   
      }
    }
  },
})
```

#### Custom Options
If you happen to have different branches that need updating, you can configure that as well:

```js
grunt.initConfig({
  release: {
    github: {
      options: {
        repo: 'cadwallion/factory-worker',
        remote: 'cadwallion',
        branch: 'releases'
      }
    }
  },
})
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History
_(Nothing yet)_
