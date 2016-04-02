class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  private

    # Confirms a logged in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "You gotta pay to play my friend."
        redirect_to login_url
      end
    end

end