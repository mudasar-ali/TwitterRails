class LikesController < ApplicationController
  before_action :set_tweet, only: %i[create destroy]

  def create
  current_user.likes.create!(like_params)
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("post can not be liked", e.message, :unprocessable_entity)
  end

  def destroy
    @like = Like.find_by!(user_id: current_user, tweet_id: params[:tweet_id])
    @like.destroy
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("can not unlike post", e.message, :unprocessable_entity)
  end

  private

  def like_params
    params.permit(:tweet_id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be found", e.message, :not_found)
  end
end
