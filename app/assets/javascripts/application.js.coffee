#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

window.App =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->

  Todos = new window.App.Collections.Todos

  class AppView extends Backbone.View

    el: $ '#todoapp'

    statsTemplate: JST["templates/todos/stats"]

    events:
      "keypress #new-todo"  : "createOnEnter"
      "keyup #new-todo"     : "showTooltip"
      "click .todo-clear a" : "clearCompleted"
      "click .mark-all-done": "toggleAllComplete"

    initialize: ->
      _.bindAll @, 'addOne', 'addAll', 'render', 'toggleAllComplete'

      @input = @$ '#new-todo'
      @allCheckbox = @$('.mark-all-done')[0]

      Todos.bind 'add',   @addOne
      Todos.bind 'reset', @addAll
      Todos.bind 'all',   @render

      Todos.fetch()

    render: ->
      done = Todos.done().length
      remaining = Todos.remaining().length

      @$('#todo-stats').html @statsTemplate
        total:      Todos.length
        done:       done
        remaining:  remaining

      @allCheckbox.checked = !remaining

    addOne: (todo)->
      view = new window.App.Views.Todos.TodoView model: todo
      @$('#todo-list').append view.render().el

    addAll: -> Todos.each @addOne

    newAttributes: ->
      content: @input.val()
      order:   Todos.nextOrder()
      done:    false

    createOnEnter: (e)->
      if e.keyCode == 13
        Todos.create @newAttributes()
        @input.val ''

    clearCompleted: ->
      _.each Todos.done(), (todo)-> todo.clear()
      false

    showTooltip: (e)->
      tooltip = @$ '.ui-tooltip-top'
      val = @input.val()
      tooltip.fadeOut()
      clearTimeout @tooltipTimeout if @tooltipTimeout
      return if val == '' || val == @input.attr 'placeholder'
      show = -> tooltip.show().fadeIn()
      @tooltipTimeout = _.delay show, 1000

    toggleAllComplete: ->
      done = @allCheckbox.checked
      Todos.each (todo)-> todo.save 'done': done

  App = new AppView