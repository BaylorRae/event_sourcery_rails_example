module CommandHandler
  def self.included(klass)
    klass.extend ClassMethods
  end

  def call(command)
    return unless self.class.events.has_key?(command.class)
    instance_exec command, &self.class.events[command.class]
  end

  private

  module ClassMethods
    def events
      @events ||= {}
    end

    def on(event_klass, &block)
      if self.events.has_key?(event_klass)
        raise StandardError.new("#{event_klass} is already registered")
      end

      self.events[event_klass] = block
    end
  end
end
