class TodoCommandHandler
  attr_reader :repository

  def initialize(repository: EventSourceryRails.repository)
    @repository = repository
  end

  def add(command)
    aggregate = repository.load(Todo, command.aggregate_id)
    aggregate.add(command)
    repository.save(aggregate)
  end
end
