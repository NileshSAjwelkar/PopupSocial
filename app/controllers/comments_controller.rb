class CommentsController < ApplicationController
  before_action :find_commentable
  
  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_back(fallback_location: "/")
    else
      redirect_back(fallback_location: "/")
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
