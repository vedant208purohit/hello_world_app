class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[update destroy]

  def index
    @todo_items = TodoItem.order(created_at: :desc)
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)

    if @todo_item.save
      redirect_to root_path
    else
      @todo_items = TodoItem.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to root_path
    else
      @todo_items = TodoItem.order(created_at: :desc)
      @todo_item = TodoItem.new
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
    redirect_to root_path
  end

  private

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :completed)
  end
end