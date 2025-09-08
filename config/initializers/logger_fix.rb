# Fix for Ruby 3.2.0 Logger compatibility issue
# This initializer ensures Logger is loaded before ActiveSupport tries to use it

begin
  require 'logger'
  require 'logger/severity'
rescue LoadError => e
  Rails.logger.error "Failed to load logger: #{e.message}" if defined?(Rails)
end
