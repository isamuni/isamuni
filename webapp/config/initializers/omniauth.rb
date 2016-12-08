# frozen_string_literal: true
# Registers isamuni_app_id and isamuni_app_secret with omniauth
# only if we are starting the server, so it doesn't run on rake tasks
if defined?(Rails::Server)
  raise 'ISAMUNI_APP_ID not set' unless ENV['ISAMUNI_APP_ID']
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET']
  end
end
