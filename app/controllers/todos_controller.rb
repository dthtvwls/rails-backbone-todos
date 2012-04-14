class TodosController < ApplicationController
  respond_to :html, :json

  def index
    @todos = Todo.all
    respond_with @todos
  end

  def show
    @todo = Todo.find params[:id]
    respond_with @todo
  end

  def new
    @todo = Todo.new
    respond_with @todo
  end

  def edit
    @todo = Todo.find params[:id]
  end

  def create
    @todo = Todo.new params[:todo]
    @todo.save
    respond_with @todo
  end

  def update
    @todo = Todo.find params[:id]
    @todo.update_attributes params[:todo]
    respond_with @todo
  end

  def destroy
    @todo = Todo.find params[:id]
    @todo.destroy
    head :ok
  end
end
