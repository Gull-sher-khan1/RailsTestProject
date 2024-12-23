# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post_through_params, only: :create
  before_action :set_like, :set_post_through_like, only: :destroy

  def create
    @like = @post.likes.create(user_id: strong_params[:user_id])
    redirect_to root_url, alert: 'can not create like' if @like.nil?
  end

  def destroy
    redirect_to root_url, alert: 'can not unlike' unless @like.destroy
  end

  private

  def strong_params
    params.permit(:likeable_id, :from, :user_id, :id)
  end

  def set_like
    @like = Like.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not set like, try reloading' if @like.nil?
  end

  def set_post_through_params
    @post = Post.find_by(id: strong_params[:likeable_id])
    redirect_to root_url, alert: 'can not set post, try reloading' if @post.nil?
  end

  def set_post_through_like
    @post = Post.find_by(id: @like.likeable_id)
    redirect_to root_url, alert: 'can not set post, try reloading' if @post.nil?
  end
end
