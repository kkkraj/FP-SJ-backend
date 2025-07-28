source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.6.0'
# Use Puma as the app server
gem 'puma', '~> 6.6.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.11'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 5.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.20'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18.6', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 3.0.0'

# JWT for authentication
gem 'jwt', '~> 3.1.2'

# JSON serialization
gem 'active_model_serializers', '~> 0.10.15'

# Environment variables management
gem 'figaro', '~> 1.3.0'

# Security and audit tools
gem 'bundle-audit', '~> 0.9.0.1', group: [:development, :test]
gem 'brakeman', '~> 6.1.2', group: [:development, :test]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Testing framework
  gem 'rspec-rails', '~> 7.0.0'
  gem 'factory_bot_rails', '~> 6.4.0'
  gem 'faker', '~> 3.2.0'
end

group :development do
  gem 'listen', '~> 3.9.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.3.0'
  gem 'spring-watcher-listen', '~> 2.1.0'
  # Code quality tools
  gem 'rubocop', '~> 1.57.0', require: false
  gem 'rubocop-rails', '~> 2.20.0', require: false
  gem 'rubocop-rspec', '~> 2.24.0', require: false
  # API documentation
  gem 'rswag-api', '~> 2.13.0'
  gem 'rswag-ui', '~> 2.13.0'
  gem 'rswag-specs', '~> 2.13.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
