Rails.application.routes.draw do
  resources :payments
  resources :assignments
  resources :comments
  resources :activities
  resources :users
  post '/auth/login', to: 'authentication#login'
end
