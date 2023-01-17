class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.followings << @user
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("User not exist",e.errors.full_messages, :unprocessable_entity)
  end

  def destroy
    following_data = current_user.following_users.find_by(following_id: params[:id])
    if following_data
      following_data.destroy
    end
  rescue ActiveRecord::RecordNotFound => e
      rendering_errors("something went wrong",e.errors.full_messages, :unprocessable_entity)
  end

  def followers
    @user = User.find(params[:id])
    if @user
      render json:{
        followers: @user.followers
      }
    end
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.errors.full_messages, :not_found)
  end

  def followings
    @user = User.find(params[:id])
    if @user
      render json:{
        followings: @user.followings
      }
    end
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.errors.full_messages, :not_found)
  end

end
