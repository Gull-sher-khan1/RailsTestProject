class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'navbar'
  def index
    @user = current_user
    @followers = User.all
    @posts = Post.includes(:user)
    @user_ids = @posts.distinct.pluck("user_id")
    @users = User.find(@user_ids)
    @comments = Comment.none
    @likes_posts = Like.includes(:user).where(likeable_type: "Post")
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
end
