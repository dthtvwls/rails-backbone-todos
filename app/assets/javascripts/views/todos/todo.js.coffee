App.Views.Todos ||= {}

class App.Views.Todos.TodoView extends Backbone.View

  tagName: "li"

  template: JST["templates/todos/item"]

  events:
    "click .check"               : "toggleDone"
    "dblclick label.todo-content": "edit"
    "click span.todo-destroy"    : "clear"
    "keypress .todo-input"       : "updateOnEnter"
    "blur .todo-input"           : "close"

  initialize: ->
    _.bindAll @, 'render', 'close', 'remove'
    @model.bind 'change', @render
    @model.bind 'destroy', @remove

  render: ->
    $(@el).html @template @model.toJSON()
    @input = @$ '.todo-input'
    @

  toggleDone: -> @model.toggle()

  edit: ->
    $(@el).addClass 'editing'
    @input.focus()

  close: ->
    @model.save content: @input.val()
    $(@el).removeClass 'editing'

  updateOnEnter: (e)-> @close() if e.keyCode == 13

  clear: -> @model.clear()
