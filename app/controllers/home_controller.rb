# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'navbar'

  include UserConcern
  before_action :set_search, :set_comment, :set_posts, :set_likes, :set_stories, :set_attachments, only: [:index, :search]
  before_action :set_post, only: :get_comments
  before_action :set_attachment, :set_story, only: :show_story
  def index
  end

  # get comments of the specific post whose id has been sent through the parameters in request
  def get_comments
    @comments = @post.comments
    set_users(@comments)
    respond_to do |format|
      format.js { render 'render_comments.js.erb', layout: false, locals: { users: @users, user_ids: @user_ids} }
    end
  end

  #show story when specific story is clicked
  def show_story
    if @attachment == nil || @story == nil
      redirect_to helpers.flash_helper('could not find story, try reloading', :alert)
    else
      respond_to do |format|
        format.js { render 'home/render_story.js.erb', layout: false }
      end
    end
  end

  #search and show result when user tries to search users registered in app
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

  def set_post
    @post = Post.find_by_id(strong_params[:commentable_id])
    redirect_to helpers.flash_helper('could not retrieve comments, try reloading', :alert) if @post==nil
  end

  def set_attachment
    @attachment = Attachment.get_attachment(strong_params[:id])
    @attachment=nil if @attachment.class.to_s == 'Attachment::ActiveRecord_Relation' && @attachment.count>1
  end

  def set_story
    @story = Story.get_story(@attachment==nil ? 0 : @attachment.attachable_id)
    @story=nil if @attachment.class.to_s == 'Attachment::ActiveRecord_Relation' && @story.count>1
  end
end
