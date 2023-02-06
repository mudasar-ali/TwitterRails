class UsersController < ApplicationController
  def show
    @user = User.includes(:followers, :followings, tweets: [:likes, comments: [:user]]).find_by!(id:params[:id])
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end

  def update
    @user = User.find(params[:id])
    @user.delete_previous_picture(@user.prof_pic.url,params[:prof_pic])
    @user.update!(update_params)
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User can not be updated",e.message, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    rendering_errors("User can not be updated",e.message, :unprocessable_entity)
  end

  def search
    @users = User.search("%#{params[:value]}%")
  end

  private
    def update_params
      params.permit(:name, :username, :prof_pic, :bio)
    end
end
