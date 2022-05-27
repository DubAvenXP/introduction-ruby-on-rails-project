Rails.application.routes.draw do
  resources :activities
  resources :users
  post '/auth/login', to: 'authentication#login'
end
