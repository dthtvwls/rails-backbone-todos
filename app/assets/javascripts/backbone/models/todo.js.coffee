class App.Models.Todo extends Backbone.Model
  paramRoot: 'todo'

  defaults:
    content: null
    done: null

class App.Collections.TodosCollection extends Backbone.Collection
  model: App.Models.Todo
  url: '/todos'
