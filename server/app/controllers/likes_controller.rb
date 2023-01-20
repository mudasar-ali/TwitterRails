class LikesController < ApplicationController

  def create
    if current_user.likes.create!(like_params)
      render json:{
        success: true,
      }
    end
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("post can not be liked", e.message, :unprocessable_entity)
  end

  def destroy
    @like = Like.find_by(user_id: current_user, tweet_id: params[:tweet_id])
    if @like
      @like.destroy
    else
      rendering_errors("can not unlike post", "", :unprocessable_entity)
    end
  end

  private

  def like_params
    params.permit(:tweet_id)
  end
end
