def processors(db_connection, tracker)
  [
    Todo::AllTodosProjector.new(
      db_connection: db_connection,
      tracker: tracker
    )
  ]
end

namespace :processors do
  task setup: :environment do
    processors(EventSourceryRails.projections_database, EventSourceryRails.tracker).each(&:setup)
  end

  task run: :environment do
    puts "Starting Event Stream Processors"

    EventSourceryRails.projections_database.disconnect

    $stdout.sync = true

    EventSourcery::EventProcessing::ESPRunner.new(
      event_processors: processors(EventSourceryRails.projections_database, EventSourceryRails.tracker),
      event_source: EventSourceryRails.event_source
    ).start!
  end
end
