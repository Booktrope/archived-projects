require 'hello_sign'

HelloSign.configure do |config|
  config.api_key = ENV['hellosign_api_key']
  # You can use email_address and password instead of api_key. But api_key is recommended
  # If api_key, email_address and password are all present, api_key will be used.
  # config.email_address = 'email_address'
  # config.password = 'password'
  # config.client_id = 'your_client_id' #required only when you want to use embedded or OAuth
  # config.client_secret = 'your_client_secret' #required only when you want to use OAuth
end
