# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: :create
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @post.comments.create(user_id: strong_params[:user_id], text: strong_params[:comment][:text])
    redirect_to root_url, alert: 'can not create comment' if @comment.nil? || @comment.id==nil
    @user_ids = [current_user.id]
    @users = [current_user]
  end

  def destroy
    redirect_to root_url, alert: 'can not destroy comment' unless @comment.destroy
  end

  def update
    redirect_to root_url, alert: 'can not update comment' unless @comment.update(text: params[:comment][:text])
  end

  def edit; end

  private

  def strong_params
    params.permit(:id, :user_id, comment: %i[commentable_id text])
  end

  def set_post
    @post = Post.find_by(id: strong_params[:comment][:commentable_id])
    redirect_to root_url, alert: 'can not create comment, try reloading' if @post.nil?
  end

  def set_comment
    @comment = Comment.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not complete action, try reloading' if @comment.nil?
  end
end
