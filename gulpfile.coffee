path               = require 'path'
gulp               = require 'gulp'
rename             = require 'gulp-rename'
gutil              = require 'gulp-util'
webpack            = require 'gulp-webpack'
named              = require 'vinyl-named'
{ argv }           = require 'yargs'
{ UglifyJsPlugin } = require('webpack').optimize
BowerWebpackPlugin = require 'bower-webpack-plugin'

PRODUCTION = argv.production

# webpackConfig.plugins = webpackConfig.plugins.concat(new webpack.optimize.UglifyJsPlugin())
# webpackConfig.output.filename = "main.js"
# webpackConfig.devtool = null

gulp.task 'copy', (callback)->
  gulp.src('extensions/**/*')
    .pipe gulp.dest 'dist'


gulp.task 'webpack', ['copy'], (callback) ->
  webpackConfig =
    entry:
      extension : './src/extension.coffee'
      background : './src/background.coffee'
    target: 'web'
    debug: true
    'display-error-details': true
    output:
      filename: '[name].js'
    devtool: '#inline-source-map'
    resolve: modulesDirectories: ['bower_components','src']
    module:
      loaders: [ { test: /\.coffee$/, loader: 'coffee-loader'} ]
      noParse: /\.min\.js/
    plugins: [new BowerWebpackPlugin]

  if PRODUCTION
    webpackConfig.plugins = webpackConfig.plugins.concat new UglifyJsPlugin(compress:drop_console:true)
    webpackConfig.devtool = ''

  gulp.src('./src/*.coffee')
    .pipe named()
    .pipe webpack(webpackConfig)

    .pipe gulp.dest 'dist/Chrome'
    .pipe gulp.dest 'dist/Firefox'
    .pipe gulp.dest 'dist/Opera'
    .pipe gulp.dest 'dist/Safari.safariextension'

gulp.task 'dev', ['build'], ->
  pathsToWatch = [
    './src/**/*'
    'webpack.config.js'
    'bower.json'
    'gulpfile.coffee'
    './extensions/**/*'
  ]

  # When /src changes, fire off a rebuild
  gulp.watch pathsToWatch, (evt) ->
    gutil.log "Detected change #{evt.path}"
    gulp.run 'build'


gulp.task 'build', ['copy', 'webpack'], ->

gulp.task 'default', ['dev'], ->


# execWebpack = (config) ->
#   webpack config, (err, stats) ->
#     if (err) then throw new gutil.PluginError("execWebpack", err)
#     gutil.log("[execWebpack]", stats.toString({colors: true}))
