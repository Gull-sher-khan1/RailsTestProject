class UsersController < ApplicationController
  layout 'navbar'
  def show
    @user=User.find(current_user.id)
    @profile_user=User.find(params[:id])
    if @profile_user.id == current_user.id || (@profile_user.id != current_user.id && @profile_user.private_account!=true)
      @posts = Post.where(user_id: @profile_user.id)
    else
      @posts = nil
    end
    @likes_posts = Like.includes(:user).where(likeable_type: "Post")
  end
  def edit
    @user=User.find(params[:id])
    respond_to do |format|
      format.js {render 'edit_name_form.js.erb', layout: false, locals:{user: @user}}
    end
  end
  def update
    @user=User.find(params[:id])
    if params[:from] == "private"
      @user.update(private_account: @user.private_account!=true ? true : false)
      respond_to do |format|
        format.js {render 'change_private_button.js.erb', layout: false}
      end
    else
      @user.update(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
      respond_to do |format|
        format.js {render 'edit_name_form.js.erb', layout: false, locals: {user: @user}}
      end
    end
  end
end
