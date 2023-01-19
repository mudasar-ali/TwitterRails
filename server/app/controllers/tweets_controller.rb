class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets=Tweet.all
    render json: {
      posts: @tweets
    },status: :ok
  end

  def create
    byebug
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
    @tweet = Tweet.find(params[:id])
    if @tweet
      render json: {
        post: @tweet
      },status: :ok
    end
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be found", e.message, :unprocessable_entity)
  end

  def update
     @tweet = Tweet.find(params[:id])
     if @tweet && @tweet.update!(tweet_params)
      render json: {
        post: @tweet
      },status: :ok
     end
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be found", e.message, :unprocessable_entity)
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("Tweet can not be updated",e.message, :unprocessable_entity)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
     if @tweet
      @tweet.destroy
     end
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be deleted", e.message, :unprocessable_entity)
  end

  private
    def tweet_params
      params.permit(:caption, {images_attributes: [:id, :post_id, :pictures]})
    end

end
