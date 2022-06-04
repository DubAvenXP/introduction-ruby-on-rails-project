Rails.application.routes.draw do
  # TODO: nested routes
  resources :activities do
    resources :assignments do
      resources :payments
    end
    resources :comments
  end
  resources :users
  post '/auth/login', to: 'authentication#login'
end
