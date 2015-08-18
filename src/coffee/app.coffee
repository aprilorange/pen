React = require 'react'

App = React.createClass 
  render: ->
    return <div>
        hi!
      </div>

React.render <App />, document.body
