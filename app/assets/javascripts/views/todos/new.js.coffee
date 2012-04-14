App.Views.Todos ||= {}

class App.Views.Todos.NewView extends Backbone.View

  template: JST["templates/todos/new"]

  events: "submit #new-todo": "save"

  constructor: (options)->
    super options
    @model = new @collection.model()

    @model.bind "change:errors", =>
      @render()

  save: (e)->
    e.preventDefault()
    e.stopPropagation()

    @model.unset "errors"

    @collection.create @model.toJSON(),
      success: (todo)=>
        @model = todo
        window.location.hash = "/#{@model.id}"

      error: (todo, jqXHR)=>
        @model.set errors: $.parseJSON jqXHR.responseText

  render: ->
    $(@el).html @template @model.toJSON()
    @$("form").backboneLink @model
    @
