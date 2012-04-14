class App.Collections.Todos extends Backbone.Collection

  model: App.Models.Todo
  url: '/todos'

  done: -> @filter (todo)-> todo.get 'done'

  remaining: -> @without.apply @, @done()

  nextOrder: ->
    return 1 if !@.length
    return @last().get 'order' + 1

  comparator: (todo)-> todo.get 'order'