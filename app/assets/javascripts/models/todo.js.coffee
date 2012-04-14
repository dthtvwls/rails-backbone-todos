class App.Models.Todo extends Backbone.Model

  paramRoot: 'todo'

  defaults:
    content: 'empty todo...'
    done: false

  initialize: ->
    if !@get 'content'
      @set "content": @defaults.content

  toggle: -> @save done: !@get 'done'

  clear: -> @destroy()
