class UsersController < ApplicationController
  def show
    @user = User.includes(:followers, :followings, tweets: [:likes, comments: [:user]]).find(params[:id])
    byebug
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end
end
