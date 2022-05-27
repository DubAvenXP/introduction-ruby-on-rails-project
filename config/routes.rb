Rails.application.routes.draw do
  resources :comments
  resources :activities
  resources :users
  post '/auth/login', to: 'authentication#login'
end
