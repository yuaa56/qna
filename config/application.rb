require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :en
    #config.hosts << "localhost"

    #config.assets.enabled = true
    #config.assets.version = '1.0'
    # Defaults to '/assets'
    #config.assets.prefix = '/asset-files'


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_cable.allowed_request_origins = ['https://rubyonrails.com', %r{http://ruby.*}]
    config.action_cable.disable_request_forgery_protection = false
    config.action_mailer.default_url_options = { :host => "localhost" }

    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in:  90.minutes }

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
      g.fixtures_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
