class TodosController < ApplicationController

  def create
    command = AddTodo.build(title: todo_params[:title],
                            aggregate_id: SecureRandom.uuid)
    command_handler.call(command)
    head :created
  end

  def update
    command = UpdateTitle.build(title: todo_params[:title],
                                aggregate_id: params[:id])
    command_handler.call(command)
    head :ok
  end

  private

  def todo_params
    params.permit(:id, :title)
  end

  def command_handler
    @command_handler ||= TodoCommandHandler.new
  end

end
