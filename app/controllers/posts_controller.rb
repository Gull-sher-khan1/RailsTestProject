class PostsController < ApplicationController
  # before editting find wether the current user is authorized?
  # updation
  # ajax edit button
  def create
    @attachments=strong_params[:post][:attachment]
    params[:post].delete(:attachment)
    @post=Post.new(strong_params[:post])
    @post.user_id=strong_params[:user_id]
    @post.save
    respond_to do |format|
      format.js {render 'posts/send_attachments.js.erb', layout: false, locals: {post_id: @post.id}}
    end
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
    post = Post.find(params[:id])
    post.update(text: params[:post][:text])
    respond_to do |format|
      format.js {render 'home/edit_post.js.erb', layout: false, locals: {post: post}}
    end
  end
  private
  def strong_params
    params.permit!
  end
end
