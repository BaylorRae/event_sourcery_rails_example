Rails.application.routes.draw do
  post '/todos', to: 'todos#create'
  patch '/todos/:id', to: 'todos#update'
end
