Rails.application.routes.draw do
  resources :activities
  resources :user_activities
  resources :moods
  resources :user_moods
  resources :diary_entries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      post '/login', to: 'auth#create'
      get '/current_user', to: 'users#profile'
    end
  end
end
