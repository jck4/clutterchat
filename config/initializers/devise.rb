Devise.setup do |config|

  # Placeholder for the mailer sender. This can be ignored if you're not using email.
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'
  discord_oauth = Rails.application.credentials.discord
  config.omniauth :discord, ENV['DISCORD_CLIENT_ID'], ENV['DISCORD_CLIENT_SECRET']
  config.authentication_keys = [:discord_username]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
