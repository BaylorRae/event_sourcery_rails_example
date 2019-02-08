namespace :event_sourcery do
  namespace :db do
    task migrate: :environment do
      database = EventSourcery::Postgres.config.event_store_database
      begin
        EventSourcery::Postgres::Schema.create_event_store(db: database)
      rescue StandardError => e
        puts "Could not create event store: #{e.class.name} #{e.message}"
      end
    end
  end
end
