module Authorization
  def current_user?(user)
    user == current_user
  end

  def current_user
    current_cookies || current_session
  end

  def current_session
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def current_cookies
    if (user_id = cookies.signed[:user_id])
      authenticated?(User.find_by(id: user_id))
    end
  end

  def logged_in?
    !!current_user
  end

  def require_logout
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to me_url
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
