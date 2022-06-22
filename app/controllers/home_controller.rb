# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'navbar'

  include UserConcern
  before_action :set_search, :set_comment, :set_posts, :set_likes, :set_stories, :set_attachments, only: [:index, :search]
  def index

  end

  def get_comments
    post = Post.find_by(id: strong_params[:commentable_id])
    @comments = post.comments
    set_users(@comments)
    respond_to do |format|
      format.js do
        render 'render_comments.js.erb', layout: false, locals: { users: @users, user_ids: @user_ids, post: post }
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
    @found_users = @search_query.result(distinct: true)
    respond_to do |format|
      format.js { render 'home/send_users.js.erb', layout: false }
    end
  end
  private
  def strong_params
    params.permit!
  end



  def set_comment
    @comments = Comment.none
  end

  def set_posts
    @posts = Post.user_posts
    set_users(@posts)
  end

  def set_likes
    @likes_posts = Like.like_users
  end

  def set_stories
    @stories = Attachment.random_stories
  end

  def set_attachments
    @attachments = Attachment.posts_attachments(@posts)
    @user_ids << current_user.id if @user_ids.index(current_user.id).nil?
    @user_attachments = Attachment.users_attachments(@user_ids)
  end

end
