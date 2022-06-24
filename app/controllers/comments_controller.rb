# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: :create
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.create(user_id: strong_params[:user_id], text: strong_params[:comment][:text])
    @user_ids = [current_user.id]
    @users = [current_user]
    respond_to do |format|
      format.js { render 'home/render_comment.js.erb', layout: false}
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js { render 'home/remove_comment.js.erb', layout: false, locals: { comment_id: strong_params[:id] } }
    end
  end

  def update
    @comment.update(text: params[:comment][:text])
    respond_to do |format|
      format.js { render 'home/edit_comment.js.erb', layout: false}
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'home/edit_comment.js.erb', layout: false}
    end
  end

  private

  def strong_params
    params.permit(:id, :user_id, :authenticity_token ,comment: [:commentable_id, :text])
  end

  def set_post
    @post = Post.find_by_id(strong_params[:comment][:commentable_id])
    render js: "window.location = ' #{helpers.flash_helper('could not create comment, try reloading', :alert)}'" if @post == nil
  end

  def set_comment
    @comment = Comment.find_by_id(strong_params[:id])
    render js: "window.location = ' #{helpers.flash_helper('could not complete action, try reloading', :alert)}'" if @comment == nil
  end
end
