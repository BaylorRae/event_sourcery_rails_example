class TodoCommandHandler
  attr_reader :repository

  def initialize(repository: EventSourceryRails.repository)
    @repository = repository
  end

  def add(command)
    with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
      aggregate.add(command)
    end
  end

  def update_title(command)
    with_aggregate(aggregate_id: command.aggregate_id) do |aggregate|
      aggregate.change_title(command)
    end
  end

  private

  def with_aggregate(aggregate_id:)
    aggregate = repository.load(Todo, aggregate_id)
    yield aggregate
    repository.save(aggregate)
  end
end
