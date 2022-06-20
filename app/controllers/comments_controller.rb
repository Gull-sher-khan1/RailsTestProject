class CommentsController < ApplicationController

  def create
    post=Post.find_by_id(strong_params[:comment][:commentable_id])
    @comment=post.comments.create(user_id: strong_params[:user_id], text: strong_params[:comment][:text])
    if @comment
      @user_ids = [current_user.id]
      @users = User.find(@user_ids)
      respond_to do |format|
        format.js {render 'home/render_comment.js.erb', layout: false, locals: {post: post}}
      end
    end
  end

  def destroy
    @comment=Comment.find_by_id(strong_params[:id])
    @comment.destroy
    respond_to do |format|
      format.js {render 'home/remove_comment.js.erb', layout: false, locals: {comment_id: params[:id]}}
    end
  end

  def update
    @comment = Comment.find_by_id(strong_params[:id])
    @comment.update(text: params[:comment][:text])
    respond_to do |format|
      format.js {render 'home/edit_comment.js.erb', layout: false, locals: {comment: @comment}}
    end
  end

  def edit
    @comment =  Comment.find_by_id(strong_params[:id])
    respond_to do |format|
      format.js {render 'home/edit_comment.js.erb', layout: false, locals: {comment: @comment}}
    end
  end

  private
  def strong_params
    params.permit!
  end
end
