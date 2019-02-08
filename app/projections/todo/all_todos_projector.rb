module Todo
  class AllTodosProjector
    include EventSourcery::Postgres::Projector

    projector_name :all_todos

    table :todos do
      column :id, 'UUID NOT NULL'
      column :title, :text
      column :created_at, DateTime
      column :updated_at, DateTime
    end

    project TodoAdded do |event|
      table(:todos).insert(
        id: event.aggregate_id,
        title: event.title,
        created_at: event.created_at,
        updated_at: event.created_at
      )
    end

    project TodoTitleChanged do |event|
      table(:todos).where(todo_id: event.aggregate_id)
        .update(title: event.title, updated_at: event.created_at)
    end
  end
end
