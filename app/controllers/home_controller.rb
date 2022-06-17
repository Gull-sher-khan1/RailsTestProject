class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'navbar'
  def index
    @q = User.ransack(params[:q])
    @user = current_user
    following_ids= Following.where(follower_id: current_user.id,request_accepted: true).pluck(:user_id)
    @followers = User.where(id: following_ids)
    @following_attachments = Attachment.where(attachable_id: following_ids, attachable_type: 'User')
    @posts = Post.includes(:user)
    @user_ids = @posts.distinct.pluck("user_id")
    @users = User.find(@user_ids)
    @comments = Comment.none
    @likes_posts = Like.includes(:user).where(likeable_type: "Post")
    @attachments = Attachment.where(attachable_id: @posts.pluck(:id), attachable_type: 'Post')
    @stories = Attachment.where(attachable_type: 'Story').order('RANDOM()').limit(10)
    if @user_ids.index(current_user.id) == nil
      @user_ids<<current_user.id
    end
    @user_attachments = Attachment.where(attachable_id: @user_ids, attachable_type: 'User')
  end
  def get_comments
    post=Post.find_by_id(params[:commentable_id])
    @comments = post.comments.all.limit(10)
    user_ids = Comment.includes(:user).distinct.pluck("user_id")
    @users = User.find(user_ids)
    respond_to do |format|
      format.js {render 'render_comments.js.erb', layout: false, locals: {users: @users, user_ids: user_ids, post: post}}
    end
  end
  def show_story
    @attachment=Attachment.find(params[:id])
    @story=Story.find(@attachment.attachable_id)
    respond_to do |format|
      format.js {render 'home/render_story.js.erb', layout: false}
    end
  end
  def search
    @q = User.ransack(params[:q])
    @found_users = @q.result(distinct: true)
    respond_to do |format|
      format.js {render 'home/send_users.js.erb', layout: false}
    end
  end
end
