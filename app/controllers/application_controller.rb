class ApplicationController < ActionController::Base
  include Authorization
  include Authentication

  helper_method :logged_in?, :current_user
end
