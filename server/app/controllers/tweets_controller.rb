class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show update destroy]

  def index
    @tweets=Tweet.all
    render json: {
      posts: @tweets
    },status: :ok
  end

  def create
    @tweet = current_user.tweets.create!(tweet_params)
    if @tweet
      render json: {
        post: @tweet
      },status: :ok
    end
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("Tweet can not be created", e.message, :unprocessable_entity)
  end

  def show
      render json: {
        post: @tweet
      },status: :ok
  end

  def update
     if @tweet && @tweet.update!(tweet_params)
      render json: {
        post: @tweet
      },status: :ok
     end
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("Tweet can not be updated",e.message, :unprocessable_entity)
  end

  def destroy
    @tweet.destroy
  end

  private
    def tweet_params
      params.permit(:caption, {images_attributes: [:id, :post_id, :pictures]})
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    rescue ActiveRecord::RecordNotFound=> e
      rendering_errors("Tweet can not be deleted", e.message, :not_found)
    end

end
