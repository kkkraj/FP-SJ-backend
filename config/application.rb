require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DiaryBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Use timezone-aware timestamps
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc

    # Enable per-form CSRF tokens
    config.action_controller.per_form_csrf_tokens = true

    # Enable origin-checking CSRF mitigation
    config.action_controller.forgery_protection_origin_check = true

    # Disable per-form CSRF tokens for API-only apps
    config.action_controller.per_form_csrf_tokens = false

    # Disable origin-checking CSRF mitigation for API-only apps
    config.action_controller.forgery_protection_origin_check = false

    # Use cookies for session storage
    config.session_store :cookie_store, key: '_diary_backend_session'

    # Use cookies for flash messages
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
  end
end
