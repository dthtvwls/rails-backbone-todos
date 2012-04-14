App.Views.Todos ||= {}

class App.Views.Todos.TodoView extends Backbone.View
  template: JST["backbone/templates/todos/todo"]

  events: "click .destroy": "destroy"

  tagName: "tr"

  destroy: ->
    @model.destroy()
    this.remove()

    false

  render: ->
    $(@el).html @template @model.toJSON()
    @
