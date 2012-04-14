#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.App =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  $.get '/todos.json', (todos)->
    window.router = new App.Routers.TodosRouter todos: todos
    Backbone.history.start()