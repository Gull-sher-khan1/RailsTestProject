# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'navbar'

  include UserConcern
  before_action :set_search, :set_comment, :set_posts, :set_likes, :set_stories, :set_attachments,
                only: %i[index search]
  before_action :set_post, only: :get_comments
  before_action :set_attachment, :set_story, only: :show_story
  def index; end

  def get_comments
    @comments = @post.comments
    set_users(@comments)
    respond_to do |format|
      format.js { render 'render_comments.js.erb', layout: false }
    end
  end

  def show_story
    respond_to do |format|
      format.js { render 'home/render_story.js.erb', layout: false }
    end
  end

  def search
    @found_users = @search_query.result(distinct: true)
    respond_to do |format|
      format.js { render 'home/send_users.js.erb', layout: false }
    end
  end

  private

  def strong_params
    params.permit(:commentable_id, :id, :authenticity_token, q: [:first_name_or_last_name_cont])
  end

  def set_comment
    @comments = Comment.none
  end

  def set_posts
    @posts = Post.includes(:user)
    set_users(@posts)
  end

  def set_likes
    @likes_posts = Like.includes(:user).like_users
  end

  def set_stories
    @stories = Attachment.random_stories
  end

  def set_attachments
    @attachments = Attachment.posts_attachments(@posts)
    @user_ids << current_user.id if @user_ids.index(current_user.id).nil?
    @user_attachments = Attachment.users_attachments(@user_ids)
  end

  def set_post
    @post = Post.find_by(id: strong_params[:commentable_id])
    redirect_to root_url, alert: 'can not retrieve comments, try reloading' if @post.nil?
  end

  def set_attachment
    @attachment = Attachment.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not find story, try reloading' if @attachment.nil?
  end

  def set_story
    @story = Story.find_by(id: @attachment.attachable_id)
    redirect_to root_url, alert: 'can not find story, try reloading' if @story.nil?
  end
end
