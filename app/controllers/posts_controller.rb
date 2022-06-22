# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    @post = Post.new(strong_params[:post])
    @post.user_id = strong_params[:user_id]
    @post.save
    @user = current_user
    @like_post = Like.post_like(@post.id)
    respond_to do |format|
      format.js do
        render 'posts/send_attachments.js.erb', layout: false,
                                                locals: { post: @post, users: [@user], user_ids: [@user.id], signed_user: @user, likes: [@like_post] }
      end
    end
  end

  def destroy
    @post = Post.find_by(id: strong_params[:id])
    @attachments = @post.attachments
    @attachments.each do |file|
      uri = file.uri.split('/', -1)
      Cloudinary::Uploader.destroy("rails_test_project/#{uri[uri.size - 1].split('.', -1)[0]}")
      file.destroy
    end
    @post.destroy
    respond_to do |format|
      format.js { render 'home/remove_post.js.erb', layout: false, locals: { post_id: strong_params[:id] } }
    end
  end

  def edit
    post = Post.find_by(id: strong_params[:id])
    respond_to do |format|
      format.js { render 'home/edit_post.js.erb', layout: false, locals: { post: post } }
    end
  end

  def update
    post = Post.find_by(id: strong_params[:id])
    post.update(text: strong_params[:post][:text])
    respond_to do |format|
      format.js { render 'home/edit_post.js.erb', layout: false, locals: { post: post } }
    end
  end

  private

  def strong_params
    params.permit!
  end
end
