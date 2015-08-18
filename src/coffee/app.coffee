React = require 'react'
mui = require 'material-ui'
ThemeManager = new mui.Styles.ThemeManager()
require '../styl/main.styl'

AppBar = mui.AppBar

App = React.createClass 
  childContextTypes:
    muiTheme: React.PropTypes.object

  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()

  render: ->
    <div className="single container">
      <AppBar
        title="Pen"
        zDepth="0"
        iconClassNameRight="muidocs-icon-navigation-expand-more" />
    </div>

React.render <App />, document.body
