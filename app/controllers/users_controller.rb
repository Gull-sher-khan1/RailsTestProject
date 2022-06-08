class UsersController < ApplicationController
  layout 'navbar'
  def show
    @user=User.find(params[:id])
    if @user.id == current_user.id || (@user.id != current_user.id && @user.private_account!=true)
      @posts = Post.where(user_id: @user.id)
    else
      @posts = nil
    end
    @likes_posts = Like.includes(:user).where(likeable_type: "Post")
  end
  def edit
  end
  def update
    @user=User.find(params[:id])
    puts params[:from]
    if params[:from] == "private"
      @user.update(private_account: @user.private_account!=true ? true : false)
      respond_to do |format|
        format.js {render 'change_private_button.js.erb', layout: false}
      end
    end
  end
end
