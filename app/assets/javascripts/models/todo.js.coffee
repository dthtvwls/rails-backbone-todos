class App.Models.Todo extends Backbone.Model

  paramRoot: 'todo'

  defaults:
    content: 'empty todo...'
    done: false

  initialize: -> @set "content": @defaults.content if !@get 'content'

  toggle: -> @save done: !@get 'done'

  clear: -> @destroy()
