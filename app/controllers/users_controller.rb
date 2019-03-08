class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update] 
  before_action :initialize_user, only: [:edit, :update] 
  before_action :correct_user, only: [:edit, :update]
  before_action :require_logout, only: [:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = current_user
    @tweet = @user.tweets.build if logged_in?
    @tweets = @user.tweets.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to me_url
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user)
          .permit(:username, :email, :password, :password_confirmation)
  end

  def correct_user
    initialize_user
    redirect_to me_url unless current_user?(@user)
  end

  def initialize_user
    @user = User.find_by(id: params[:id])
  end
end
