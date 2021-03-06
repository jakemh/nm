require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

Bundler.require(*Rails.groups)

module NextMission
  class Application < Rails::Application
    #to prevent deadlocks with faye
    # config.middleware.delete Rack::Lock
    # config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Rails.root.join("vendor","assets","bower_components","bootstrap-sass-official","assets","fonts")
   
    config.assets.precompile += [
      '*.html',
      '*/*.html'
    ]
    config.to_prepare do

      Devise::SessionsController.skip_before_filter :authenticate_user!
      Admin::AdminController.skip_before_action :authenticate_entity

      TemporaryController.skip_before_filter :authenticate_user!
      # TemporaryController.skip_before_filter :authenticate
    end

   config.action_mailer.delivery_method = :smtp
   config.action_mailer.smtp_settings = {
   :address              => "smtp.gmail.com",
   :port                 => 587,
   :domain               => "gmail.com",
   :user_name            => "nextmissionnotifications",
   :password             => ENV["capistrano_email_password"],
   :authentication       => 'plain',
   :enable_starttls_auto => true  }

   config.action_mailer.perform_deliveries = true
   config.action_mailer.raise_delivery_errors = true

   config.autoload_paths << Rails.root.join('services')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
