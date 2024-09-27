class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token, if: -> { request.path.start_with?('/users/auth/') }
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :verify_authenticity_token_with_logging
  
  private

  def verify_authenticity_token_with_logging
    if !verified_request?
      Rails.logger.error("CSRF Token Mismatch! Authenticity token: #{form_authenticity_token}")
      render plain: "CSRF token mismatch", status: :unprocessable_entity
    end
  end
end
