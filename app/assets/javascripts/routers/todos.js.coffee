class App.Routers.Todos extends Backbone.Router

  initialize: (options)->
    @todos = new App.Collections.Todos()
    @todos.reset options.todos

  routes:
    "new"      : "newTodo"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  newTodo: ->
    @view = new App.Views.Todos.NewView collection: @todos
    $("#todos").html @view.render().el

  index: ->
    @view = new App.Views.Todos.IndexView todos: @todos
    $("#todos").html @view.render().el

  show: (id) ->
    todo = @todos.get id

    @view = new App.Views.Todos.ShowView model: todo
    $("#todos").html @view.render().el

  edit: (id) ->
    todo = @todos.get id

    @view = new App.Views.Todos.EditView model: todo
    $("#todos").html @view.render().el
