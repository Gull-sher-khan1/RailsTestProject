# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'navbar'

  def index
    @search_query = User.ransack(strong_params[:q])
    @posts = Post.includes(:user)
    @user_ids = @posts.distinct.pluck('user_id')
    @users = User.find(@user_ids)
    @comments = Comment.none
    @likes_posts = Like.includes(:user).where(likeable_type: 'Post')
    @attachments = Attachment.where(attachable_id: @posts.pluck(:id), attachable_type: 'Post')
    @stories = Attachment.where(attachable_type: 'Story').order('RANDOM()').limit(7)
    @user_ids << current_user.id if @user_ids.index(current_user.id).nil?
    @user_attachments = Attachment.where(attachable_id: @user_ids, attachable_type: 'User')
  end

  def get_comments
    post = Post.find_by(id: strong_params[:commentable_id])
    @comments = post.comments.all.limit(10)
    user_ids = Comment.includes(:user).distinct.pluck('user_id')
    @users = User.find(user_ids)
    respond_to do |format|
      format.js do
        render 'render_comments.js.erb', layout: false, locals: { users: @users, user_ids: user_ids, post: post }
      end
    end
  end

  def show_story
    @attachment = Attachment.find(strong_params[:id])
    @story = Story.find_by(id: @attachment.attachable_id)
    respond_to do |format|
      format.js { render 'home/render_story.js.erb', layout: false }
    end
  end

  def search
    @search_query = User.ransack(strong_params[:q])
    @found_users = @q.result(distinct: true)
    respond_to do |format|
      format.js { render 'home/send_users.js.erb', layout: false }
    end
  end

  def strong_params
    params.permit!
  end
end
