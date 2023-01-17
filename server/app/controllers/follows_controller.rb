class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    byebug
    begin
      current_user.followings << @user
      render json:{
        message: "successfully followed"
      }
    rescue ActiveRecord::RecordInvalid => invalid
        rendering_errors(invalid.record.errors.full_messages, :unprocessable_entity)
    end
  end

  def destroy
    following_data = current_user.following_users.find_by(following_id: params[:id])
    if following_data
      following_data.destroy
      render json:{
        message: "successfully unfollowed"
      }
    else
      rendering_errors("something went wrong", :unprocessable_entity)
    end

  end
  def followers
    @user = User.find(params[:id])
    if @user
        render json:{
        followers: @user.followers
      }
    end
  end

  def followings
    @user = User.find(params[:id])
    if @user
        render json:{
        followers: @user.followings
      }
    end
  end
end
