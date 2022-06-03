class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'navbar'
  def index
    @user = current_user
    @users = User.all
    @posts = Post.all
    @comments = Comment.none
    render 'index'
  end
  def get_comments
    post=Post.find_by_id(params[:commentable_id])
    @comments = post.comments.all.limit(10)
    user_ids = Comment.includes(:user).distinct.pluck("user_id")
    @users = User.find(user_ids)
    respond_to do |format|
      format.js {render 'render_comments.js.erb', layout: false, locals: {users: @users, user_ids: user_ids, post_id: post.id}}
    end
  end
end
