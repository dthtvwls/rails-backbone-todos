$(function(){

  var Todos = new window.App.Collections.Todos;

  var TodoView = Backbone.View.extend({

    tagName: "li",

    template: JST["templates/item"],

    events: {
      "click .check"               : "toggleDone",
      "dblclick label.todo-content": "edit",
      "click span.todo-destroy"    : "clear",
      "keypress .todo-input"       : "updateOnEnter",
      "blur .todo-input"           : "close"
    },

    initialize: function() {
      _.bindAll(this, 'render', 'close', 'remove');
      this.model.bind('change', this.render);
      this.model.bind('destroy', this.remove);
    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      this.input = this.$('.todo-input');
      return this;
    },

    toggleDone: function() {
      this.model.toggle();
    },

    edit: function() {
      $(this.el).addClass("editing");
      this.input.focus();
    },

    close: function() {
      this.model.save({content: this.input.val()});
      $(this.el).removeClass("editing");
    },

    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.close();
    },

    clear: function() {
      this.model.clear();
    }

  });

  var AppView = Backbone.View.extend({

    el: $("#todoapp"),

    statsTemplate: JST["templates/stats"],

    events: {
      "keypress #new-todo"  : "createOnEnter",
      "keyup #new-todo"     : "showTooltip",
      "click .todo-clear a" : "clearCompleted",
      "click .mark-all-done": "toggleAllComplete"
    },

    initialize: function() {
      _.bindAll(this, 'addOne', 'addAll', 'render', 'toggleAllComplete');

      this.input = this.$("#new-todo");
      this.allCheckbox = this.$(".mark-all-done")[0];

      Todos.bind('add',     this.addOne);
      Todos.bind('reset',   this.addAll);
      Todos.bind('all',     this.render);

      Todos.fetch();
    },

    render: function() {
      var done = Todos.done().length;
      var remaining = Todos.remaining().length;

      this.$('#todo-stats').html(this.statsTemplate({
        total:      Todos.length,
        done:       done,
        remaining:  remaining
      }));

      this.allCheckbox.checked = !remaining;
    },

    addOne: function(todo) {
      var view = new TodoView({model: todo});
      this.$("#todo-list").append(view.render().el);
    },

    addAll: function() {
      Todos.each(this.addOne);
    },

    newAttributes: function() {
      return {
        content: this.input.val(),
        order:   Todos.nextOrder(),
        done:    false
      };
    },

    createOnEnter: function(e) {
      if (e.keyCode != 13) return;
      Todos.create(this.newAttributes());
      this.input.val('');
    },

    clearCompleted: function() {
      _.each(Todos.done(), function(todo){ todo.clear(); });
      return false;
    },

    showTooltip: function(e) {
      var tooltip = this.$(".ui-tooltip-top");
      var val = this.input.val();
      tooltip.fadeOut();
      if (this.tooltipTimeout) clearTimeout(this.tooltipTimeout);
      if (val == '' || val == this.input.attr('placeholder')) return;
      var show = function(){ tooltip.show().fadeIn(); };
      this.tooltipTimeout = _.delay(show, 1000);
    },

    toggleAllComplete: function () {
      var done = this.allCheckbox.checked;
      Todos.each(function (todo) { todo.save({'done': done}); });
    }

  });

  var App = new AppView;

});