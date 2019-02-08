require './lib/command_handler'

module Todo
  class TodoCommandHandler
    include CommandHandler

    attr_reader :repository

    def initialize(repository: EventSourceryRails.repository)
      @repository = repository
    end

    on AddTodo do |command|
      with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
        aggregate.add(command)
      end
    end

    on UpdateTodoTitle do |command|
      with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
        aggregate.change_title(command)
      end
    end

    private

    def with_aggregate(aggregate_id:)
      aggregate = repository.load(TodoAggregate, aggregate_id)
      yield aggregate
      repository.save(aggregate)
    end
  end
end
