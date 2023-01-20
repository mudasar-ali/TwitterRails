class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = Tweet.find(params[:tweet_id]).comments.includes(:user)
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be found", e.message, :not_found)
  end

  def create
    @comment = current_user.comments.create!(comment_params)
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("Comment can not be created", e.message, :unprocessable_entity)
  end

  def show
  end

  def update
    @comment.update!(comment_params)
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("Comment can not be created", e.message, :unprocessable_entity)
  end

  def destroy
    @comment.destroy
  end

  private
  def set_comment
    @comment = Comment.includes(:user).find(params[:id])
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Comment can not be found", e.message, :not_found)
  end

  def comment_params
    params.permit(:text, :tweet_id, :id)
  end
end
