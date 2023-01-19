class FollowsController < ApplicationController
  c

  def index
    @user = User.find(params[:id])
    byebug
    if @user && params[:follow_option] === "followers"
      render json:{
        followers: @user.followers
      },status: :ok
    elsif @user && params[:follow_option] === "followings"
      render json:{
        followings: @user.followings
      },status: :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end

  def create
    @user = User.find(params[:id])
    current_user.followings << @user
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("User not exist",e.message, :unprocessable_entity)
  end

  def destroy
    following_data = current_user.following_users.find_by(following_id: params[:id])
    if following_data
      following_data.destroy
    end
  rescue ActiveRecord::RecordNotFound => e
      rendering_errors("something went wrong",e.message, :unprocessable_entity)
  end

end
