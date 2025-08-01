# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.env.development? ? ['localhost:3000', 'localhost:3001', '127.0.0.1:3000', '127.0.0.1:3001'] : ENV['ALLOWED_ORIGINS']&.split(',') || []

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: Rails.env.production?,
      expose: ['Authorization']
  end
end
