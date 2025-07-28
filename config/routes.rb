Rails.application.routes.draw do
  # Health check endpoint
  get '/up', to: proc { [200, {}, ['OK']] }
  get '/health', to: proc { [200, {}, ['OK']] }

  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication
      post '/login', to: 'auth#create'
      get '/current_user', to: 'users#profile'
      
      # Resources
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :diary_entries
      resources :moods
      resources :activities
      resources :user_moods, only: [:index, :show, :create, :update, :destroy]
      resources :user_activities, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # Legacy routes for backward compatibility
  resources :activities
  resources :user_activities
  resources :moods
  resources :user_moods
  resources :diary_entries
end
