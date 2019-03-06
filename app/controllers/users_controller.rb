class UsersController < ApplicationController
  include SessionsHelper 

  before_action :require_login, only: :show
  before_action :require_logout, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = current_user 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path 
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user)
          .permit(:username, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
