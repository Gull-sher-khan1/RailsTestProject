class CommentsController < ApplicationController
  def create
    post=Post.find_by_id(params[:comment][:commentable_id])
    @comment=post.comments.new(strong_params[:comment])
    @comment.user_id=strong_params[:user_id]
    @comment.save
  end
  def destroy
    @comment=Comment.find(params[:id])
    p @comment
    @comment.destroy
    respond_to do |format|
      format.js {render 'home/remove_comment.js.erb', layout: false, locals: {comment_id: params[:id]}}
    end
  end
  private
  def strong_params
    params.permit!
  end
end
