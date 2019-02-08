class TodosController < ApplicationController

  def create
    command = AddTodo.build(title: todo_params[:title],
                            aggregate_id: SecureRandom.uuid)
    TodoCommandHandler.new.add(command)
    head :created
  end

  private

  def todo_params
    params.permit(:title)
  end

end
