raise "ISAMUNI_APP_ID not set" unless ENV['ISAMUNI_APP_ID']
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET']
end
