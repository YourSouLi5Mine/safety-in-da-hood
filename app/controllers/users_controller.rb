class UsersController < ApplicationController
  before_action :require_logout, only: [:new]
  before_action :require_login, only: [:index, :show, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = current_user
    @new_tweet = @user.tweets.build
    @my_tweets = @user.tweets.paginate(page: params[:my_tweets], per_page: 10)
    @feed = @user.feed.paginate(page: params[:feed], per_page: 14)
  end

  def edit
    @user = current_user
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
end
