# config/initializers/omniauth.rb

# Allow both POST and GET requests for OmniAuth
OmniAuth.config.allowed_request_methods = [:post, :get]

# Silence warnings about using GET for OmniAuth
OmniAuth.config.silence_get_warning = true
OmniAuth.config.request_validation_phase = nil  # Disable request validation
# Ensure CSRF token is set in the session during the request phase
OmniAuth.config.before_request_phase = ->(env) {
  env['rack.session'] ||= {}
  env['rack.session']['_csrf_token'] ||= SecureRandom.base64(32)
}
