class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show update destroy]

  def index
    @tweets = Tweet.includes(:user, :comments, :likes).all
  end

  def create
    @tweet = current_user.tweets.create!(tweet_params)
  rescue ActiveRecord::RecordInvalid => e
    rendering_errors("Tweet can not be created", e.message, :unprocessable_entity)
  end

  def show; end

  def update
    @tweet.update!(tweet_params)
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("Tweet can not be updated",e.message, :unprocessable_entity)
  end

  def destroy
    @tweet.destroy
  end

  private
    def tweet_params
      params.permit(:caption,:pictures)
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    rescue ActiveRecord::RecordNotFound=> e
      rendering_errors("Tweet can not be found", e.message, :not_found)
    end

end
