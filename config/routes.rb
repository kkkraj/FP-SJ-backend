Rails.application.routes.draw do
  # Health check endpoint
  get '/up', to: proc { [200, {}, ['OK']] }
  get '/health', to: proc { [200, {}, ['OK']] }

  # API routes
  namespace :api do
    namespace :v1 do
      # Authentication
      post '/login', to: 'auth#create'
      post '/signup', to: 'users#create'  # Add explicit signup route
      post '/forgot_password', to: 'users#forgot_password'
      get '/current_user', to: 'users#profile'
      post '/users/upload_photo', to: 'users#upload_photo'
      delete '/users/delete_photo', to: 'users#delete_photo'
      patch '/users/update_password', to: 'users#update_password'
      patch '/update_password', to: 'users#update_password'  # Alternative route for frontend
      
      # Resources
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :diary_entries
      resources :moods
      resources :activities
      resources :user_moods, only: [:index, :show, :create, :update, :destroy]
      resources :user_activities, only: [:index, :show, :create, :update, :destroy]
      resources :diary_photos
      
      # New features
      resources :goals
      resources :user_goals, only: [:index, :show, :create, :update, :destroy]
      resources :gratitudes
      resources :user_gratitudes, only: [:index, :show, :create, :update, :destroy]
      resources :journal_prompts
      resources :user_prompt_responses, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # Legacy routes for backward compatibility
  resources :activities
  resources :user_activities
  resources :moods
  resources :user_moods
  resources :diary_entries
  resources :diary_photos
  resources :goals
  resources :user_goals
  resources :gratitudes
  resources :user_gratitudes
  resources :journal_prompts
  resources :user_prompt_responses
end
