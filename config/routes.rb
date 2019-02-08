Rails.application.routes.draw do
  post '/todos', to: 'todos#create'
end
