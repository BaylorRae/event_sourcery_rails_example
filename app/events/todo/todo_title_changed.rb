module Todo
  class TodoTitleChanged < EventSourcery::Event
    def title
      body.fetch('title')
    end
  end
end
