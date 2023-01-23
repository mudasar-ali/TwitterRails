class FollowsController < ApplicationController
  before_action :find_user, only: %i[index]

  def index
    if params[:option] === "followers"
      @users = @user.followers
      elsif params[:option] === "followings"
      @users = @user.followings
    end
  end

  def create
    current_user.following_users.create!({following_id: params[:user_id]})
  rescue ActiveRecord::RecordInvalid => e
      rendering_errors("User can not be followed",e.message, :unprocessable_entity)
  end

  def destroy
    following_data = current_user.following_users.find_by!(following_id: params[:id])
    following_data.destroy!
  rescue ActiveRecord::RecordNotFound => e
      rendering_errors("something went wrong",e.message, :unprocessable_entity)
  rescue ActiveRecord::RecordNotDestroyed => e
    rendering_errors("can not be unfollow user", e.message, :unprocessable_entity)
  end
  private

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end
end
