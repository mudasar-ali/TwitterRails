class UsersController < ApplicationController
  before_action :find_user, only: %i[show follow_detail follow unfollow]
  def show
    if @user
      render json: {
        user: @user,
        posts: @user.tweets,
        like: @user.likes,
        comments: @user.comments
      }
    end
  end

  def follow_detail
    if params[:follow_option] === "followers"
      render json:{
        followers: @user.followers
      },status: :ok
      elsif params[:follow_option] === "followings"
      render json:{
        followings: @user.followings
      },status: :ok
    end
  end

  def follow
    current_user.followings << @user
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("User not exist",e.message, :unprocessable_entity)
  end

  def unfollow
    following_data = current_user.following_users.find_by(following_id: params[:user_id])
    if following_data
      following_data.destroy
    end
  rescue ActiveRecord::RecordNotFound => e
      rendering_errors("something went wrong",e.message, :unprocessable_entity)
  end
  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end
end
