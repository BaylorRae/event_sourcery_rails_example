class UpdateTitle
  attr_reader :aggregate_id, :title

  def self.build(args)
    new(args).tap(&:validate)
  end

  def initialize(params)
    @aggregate_id = params.fetch(:aggregate_id)
    @title = params.fetch(:title)
  end

  def validate
  end
end
