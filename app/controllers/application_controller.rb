class ApplicationController < ActionController::Base
  include Authorization
  include Authentication

  helper_method :logged_in?, :current_user, :current_user?

  private
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
