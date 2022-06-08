class UsersController < ApplicationController
  layout 'navbar'
  def show
    @user=User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
    @likes_posts = Like.includes(:user).where(likeable_type: "Post")
  end
end
