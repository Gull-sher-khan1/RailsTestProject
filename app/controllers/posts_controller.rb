class PostsController < ApplicationController
  def create
    @post=Post.new(strong_params[:post])
    @post.user_id=strong_params[:user_id]
    @post.save
  end
  private
  def strong_params
    params.permit!
  end
end
