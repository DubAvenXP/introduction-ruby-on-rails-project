Rails.application.routes.draw do
  # TODO: nested routes
  resources :payments
  resources :assignments
  resources :comments
  resources :activities
  resources :users
  post '/auth/login', to: 'authentication#login'
end
