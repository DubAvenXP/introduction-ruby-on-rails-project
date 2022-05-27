Rails.application.routes.draw do
  resources :assignments
  resources :comments
  resources :activities
  resources :users
  post '/auth/login', to: 'authentication#login'
end
