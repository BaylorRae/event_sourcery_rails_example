module Todo
  class TodoAdded < EventSourcery::Event
    attr_accessor :title
  end
end
