class PostsController < ApplicationController
  # before editting find wether the current user is authorized?
  # updation
  # ajax edit button
  def create
    @post=Post.new(strong_params[:post])
    @post.user_id=strong_params[:user_id]
    @post.save
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.js {render 'home/remove_post.js.erb', layout: false, locals: {post_id: params[:id]}}
    end
  end

  def edit
    post = Post.find(params[:id])
    respond_to do |format|
      format.js {render 'home/edit_post.js.erb', layout: false, locals: {post: post}}
    end
  end

  def update

  end
  private
  def strong_params
    params.permit!
  end
end
