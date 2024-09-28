class PagesController < ApplicationController
  def auth_error
    @error_message = params[:error_message]
  end
end
