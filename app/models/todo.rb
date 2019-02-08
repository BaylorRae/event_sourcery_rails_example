class Todo < ActiveRecord::Base
  def readonly?
    true
  end
end
