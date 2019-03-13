class SessionsController < ApplicationController
  before_action :require_logout, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] ? remember(user) : forget(user)
      redirect_to me_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
