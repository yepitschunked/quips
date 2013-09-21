Recaptcha.configure do |config|
  if Rails.env.production?
    config.public_key = ENV['RECAPTCHA_PUBLIC_KEY']
    config.private_key = ENV['RECAPTCHA_PRIVATE_KEY']
  end
end
