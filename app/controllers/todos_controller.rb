class TodosController < ApplicationController

  def create
    command = Todo::AddTodo.build(title: todo_params[:title],
                                  aggregate_id: SecureRandom.uuid)
    command_handler.call(command)
    head :created
  end

  def update
    command = Todo::UpdateTodoTitle.build(title: todo_params[:title],
                                          aggregate_id: params[:id])
    command_handler.call(command)
    head :ok
  end

  private

  def todo_params
    params.permit(:id, :title)
  end

  def command_handler
    @command_handler ||= Todo::TodoCommandHandler.new
  end

end
