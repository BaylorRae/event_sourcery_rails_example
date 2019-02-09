module Todo
  class AllTodosProjector
    include EventSourcery::Postgres::Projector

    projector_name :all_todos

    table :todos do
      primary_key :id, 'UUID NOT NULL', default: Sequel.lit('uuid_generate_v4()')
      column :title, :text
      column :created_at, DateTime
      column :updated_at, DateTime
      index :id, unique: true
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
      table(:todos).where(id: event.aggregate_id)
        .update(title: event.title, updated_at: event.created_at)
    end
  end
end
