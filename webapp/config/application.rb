# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Isamuni
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Nginx will take care of deflating in production
    # config.middleware.use Rack::Deflater

    config.time_zone = 'Rome'
    I18n.available_locales = [:en, :it]
    I18n.default_locale = :it

    config.before_configuration do
      # initialization code goes here
    end
    
  end
end
