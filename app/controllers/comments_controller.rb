class CommentsController < ApplicationController
  def create
    post=Post.find_by_id(params[:comment][:commentable_id])
    @comment=post.comments.new(strong_params[:comment])
    @comment.user_id=strong_params[:user_id]
    @comment.save
  end
  private
  def strong_params
    params.permit!
  end
end
