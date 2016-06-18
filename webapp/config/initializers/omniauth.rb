Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['ISAMUNI_APP_ID'], ENV['ISAMUNI_APP_SECRET']
end
