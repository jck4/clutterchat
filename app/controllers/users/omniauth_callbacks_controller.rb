class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def discord
    # Log the received auth information for debugging
    Rails.logger.info "Auth info: #{request.env['omniauth.auth'].inspect}"

    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # Log when the user is successfully persisted
      Rails.logger.info "User persisted: #{@user.inspect}"
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Discord') if is_navigational_format?
    else
      # Log the user creation failure and the associated errors
      Rails.logger.warn "User creation failed: #{@user.errors.full_messages}"
      
      # Redirect to custom error page with error message
      error_message = @user.errors.full_messages.join(", ")
      redirect_to auth_error_path(error_message: error_message)
    end
  end

  def failure
    redirect_to root_path
  end
end
