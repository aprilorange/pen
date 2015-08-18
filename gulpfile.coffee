fs = require 'fs'
path = require 'path'
glob = require 'glob'
gulp = require 'gulp'
jade = require 'gulp-jade'
webpack = require 'webpack'
gutil = require 'gulp-util'
livereload = require 'gulp-livereload'
serve = require 'gulp-serve'
webpackAssets = require './webpack-assets'
webpackConfig = require './webpack.config'

removeCacheJS = ->
  cacheJS = glob.sync('./build/js/*.js')
  if cacheJS.length > 0
    cacheJS.forEach (filename) ->
      fs.unlinkSync filename

gulp.task 'serve', serve
  port: 2393
  root: ['.']

gulp.task 'jade',  ->
  gulp.src './src/jade/index.jade'
    .pipe jade
      locals:
        assets: webpackAssets
    .pipe gulp.dest '.'
    .pipe livereload()

gulp.task 'webpack-dev', (cb) ->
  removeCacheJS()
  webpack webpackConfig, (err, stats) ->
    gutil.log '[webpack]', stats.toString()
    livereload()
    cb()

gulp.task 'webpack', (cb) ->
  removeCacheJS()
  prodConfig = Object.create webpackConfig
  prodConfig.plugins = prodConfig.plugins.concat new webpack.optimize.UglifyJsPlugin()
  webpack prodConfig.plugins, (err, stats) ->
    gutil.log '[webpack]', stats.toString()
    cb()

gulp.task 'watch', ->
  livereload.listen()
  gulp.watch './src/coffee/*.coffee', ['webpack-dev']
  gulp.watch './src/jade/*.jade', ['jade']

gulp.task 'build-dev', ['jade', 'webpack-dev']
gulp.task 'build', ['jade', 'webpack']

gulp.task 'default', ['build-dev', 'watch', 'serve']