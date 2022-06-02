class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'navbar'
  def index
    @user = current_user
    @users = User.all
    @posts = Post.all
    render 'index'
  end
end
