class TodoRecord < ActiveRecord::Base
  self.table_name = 'todos'

  def readonly?
    true
  end
end
