# EventSourcery + Rails + DSL

This example application features EventSourcery with a new ruby-like dsl for
binding a single command handler to multiple events.

The primary goal of centralizing a command handler for multiple events is to
separate the knowledge of which command handler will respond to various events.
It would allow something like the following.

By enabling this syntax it's possible to pass an array of events to be batched in a
single request.

```ruby
EventSourcery.configure do |config|
  config.command_handlers = [
    TodoCommandHandler.new
  ]
end

EventSourcery.execute_commands(*commands)
```

## Command Handler
```ruby
class TodoCommandHandler
  include CommandHandler

  attr_reader :repository

  def initialize(repository: EventSourceryRails.repository)
    @repository = repository
  end

  on AddTodo do |command|
    with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
      # do something with loaded aggregate
    end
  end

  on UpdateTitle do |command|
    with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
      # do something with loaded aggregate
    end
  end

  private

  def with_aggregate(aggregate_id:)
    aggregate = repository.load(Todo, aggregate_id)
    yield aggregate
    repository.save(aggregate)
  end
end
```

## Controller

```ruby
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
```

## Todo

- [ ] add projections
- [x] look into consolidating events and commands to a namespace.
