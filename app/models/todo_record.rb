class TodoRecord < ActiveRecord::Base
  self.table_name = 'todos'
  self.primary_key = 'id'

  def readonly?
    true
  end
end
