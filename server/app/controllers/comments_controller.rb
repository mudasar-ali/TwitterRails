class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = Comment.where(tweet_id: params[:tweet_id])
    render json: {
      comments: @comments
    },status: :ok
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Tweet can not be found", e.message, :not_found)
  end

  def create
    @comment = current_user.comments.create!(comment_params)
    if @comment
     render json: {
        comment: @comment
      },status: :ok
    end
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("Comment can not be created", e.message, :unprocessable_entity)
  end

  def show
    if @comment
    render json: {
      comment: @comment
    },status: :ok
    end
  end

  def update
    if @comment.update!(comment_params)
      render json: {
        comment: @comment
      },status: :ok
    end
  rescue ActiveRecord::RecordInvalid=> e
    rendering_errors("Comment can not be created", e.message, :unprocessable_entity)
  end

  def destroy
    @comment.destroy
  end

  private
  def set_comment
    @comment = Comment.find(:id)
  rescue ActiveRecord::RecordNotFound=> e
    rendering_errors("Comment can not be found", e.message, :not_found)
  end

  def comment_params
    params.permit(:text, :tweet_id, :id)
  end
end
