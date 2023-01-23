class LikesController < ApplicationController
  before_action :set_tweet, only: %i[create destroy]

  def create
  current_user.likes.create!(tweet_id: params[:id])
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("tweet can not be liked", e.message, :unprocessable_entity)
  end

  def destroy
    @like = Like.find_by!(user_id: current_user, tweet_id: params[:id])
    @like.destroy!
  rescue ActiveRecord::RecordNotDestroyed => e
    rendering_errors("failed to unlike tweet", e.message, :unprocessable_entity)
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("failed to unlike tweet", e.message, :unprocessable_entity)
  end

  private

  def like_params
    params.permit(:id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("Tweet can not be found", e.message, :not_found)
  end
end
