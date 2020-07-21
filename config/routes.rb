Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'auth#create'
      get '/current_user', to: 'users#profile'
      get 'users', to: 'users#index'
      get 'users/:id', to: 'users#show'
    end
  end
end
