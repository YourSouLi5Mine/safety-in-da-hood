class TweetsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to me_url 
    else
      flash[:error] = "Could not create tweet"
      redirect_to me_url
    end
  end

  def destroy
    @tweet = current_user.tweets.find_by(id: params[:id])
    @tweet.destroy
    redirect_to me_url 
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :picture)
  end
end
