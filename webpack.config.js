var fs = require('fs')
var path = require('path')
var AssetsPlugin = require('assets-webpack-plugin')
var assetsPluginInstance = new AssetsPlugin()
var HtmlPlugin = require('html-webpack-plugin')

var indexHTML = '../../index.html'
var htmlPluginInstance = new HtmlPlugin({
  title: 'Pen',
  filename: indexHTML
})

module.exports = {
  entry: ['./src/coffee/app.coffee'],
  output: {
    path: __dirname + '/build/js',
    publicPath: '/build/js/',
    filename: "bundle.[hash].js"
  },
  resolve: {
    extensions: ['', '.js', '.coffee']
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loaders: ['coffee', 'cjsx'] }
    ]
  },
  plugins: [assetsPluginInstance, htmlPluginInstance]
}