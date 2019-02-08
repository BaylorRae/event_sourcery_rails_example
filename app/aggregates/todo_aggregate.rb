class TodoAggregate
  include EventSourcery::AggregateRoot

  def add(command)
    apply_event(
      Todo::TodoAdded,
      aggregate_id: command.aggregate_id,
      body: { title: command.title }
    )
  end

  def change_title(command)
    apply_event(
      Todo::TodoTitleChanged,
      aggregate_id: command.aggregate_id,
      body: { title: command.title }
    )
  end

  apply Todo::TodoAdded do |event|
    @aggregate_id = event.aggregate_id
    @title = event.body.fetch('title')
  end

  apply Todo::TodoTitleChanged do |event|
    @aggregate_id = event.aggregate_id
    @title = event.title
  end
end
