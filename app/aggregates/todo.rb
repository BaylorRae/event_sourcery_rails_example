class Todo
  include EventSourcery::AggregateRoot

  def add(command)
    apply_event(
      TodoAdded,
      aggregate_id: command.aggregate_id,
      body: { title: command.title }
    )
  end

  apply TodoAdded do |event|
    @aggregate_id = event.aggregate_id
    @title = event.body.fetch('title')
  end
end
