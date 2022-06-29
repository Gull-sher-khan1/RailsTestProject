# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy edit update]

  def create
    @post = Post.create(text: strong_params[:post][:text], user_id: strong_params[:user_id])
    redirect_to root_url, alert: 'could not create post' if @post.nil?
    @like_post = Like.includes(:user).post_like(@post.id)
  end

  def destroy
    @attachments = @post.attachments
    CloudinaryService.batch_destroy(@attachments)
    redirect_to root_url, alert: 'could not destroy post' unless @post.destroy
  end

  def edit; end

  def update
    redirect_to root_url, alert: 'could not destroy post' unless @post.update(text: strong_params[:post][:text])
  end

  private

  def strong_params
    params.permit(:post_id, :user_id, :id, post: [:text])
  end

  def set_post
    @post = Post.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'could not perform action for post' if @post.nil?
  end
end
