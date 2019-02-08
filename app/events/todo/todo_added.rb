module Todo
  class TodoAdded < EventSourcery::Event
    def title
      body.fetch('title')
    end
  end
end
