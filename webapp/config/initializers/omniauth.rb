# frozen_string_literal: true

# Registers isamuni_app_id and isamuni_app_secret with omniauth
# only if we are starting the server, so it doesn't run on rake tasks
if defined?(Rails::Server)
  unless ENV['ISAMUNI_APP_ID']
    Rails.logger.error "env variable ISAMUNI_APP_ID not set. Facebook-related functionalities will not work"
  else
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET']
    end
  end
end
