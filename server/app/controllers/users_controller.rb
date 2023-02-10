class UsersController < ApplicationController
  def show
    @user = User.includes(:followers, :followings, tweets: [:likes, comments: [:user]]).find_by!(id:params[:id])
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User not found",e.message, :not_found)
  end

  def update
    @user = User.find(params[:id])
    @user.update!(update_params)
  rescue ActiveRecord::RecordNotFound => e
    rendering_errors("User can not be updated",e.message, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    rendering_errors("User can not be updated",e.message, :unprocessable_entity)
  end

  def search
    @users = User.search(params[:value], fields:[:name, :username], match: :text_middle)
    if params[:tweet].present?
      @tweets = Tweet.search(params[:value], fields: [:caption], match: :text_middle).includes(:user,:likes, comments: [:user])
    end
  end

  private
    def update_params
      params.permit(:name, :username, :prof_pic, :bio, :tweet)
    end
end
