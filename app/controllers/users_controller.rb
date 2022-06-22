# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'navbar'
  include UserConcern
  before_action :set_search, only: :show

  def show

    @user = current_user
    @profile_user = User.find(strong_params[:id])
    if @profile_user.id == current_user.id || (@profile_user.id != current_user.id && @profile_user.private_account != true)
      @posts = Post.where(user_id: @profile_user.id)
    else
      @posts = Post.none
    end
    @likes_posts = Like.posts_like
    @attachments = Attachment.post_attachments(@posts.pluck(:id))
    @user_pic = @user_attachments = Attachment.users_attachments([@profile_user.id])
  end

  def edit
    @user = User.find(strong_params[:id])
    respond_to do |format|
      format.js { render 'edit_name_form.js.erb', layout: false, locals: { user: @user } }
    end
  end

  def update
    @user = User.find(strong_params[:id])
    if strong_params[:from] == 'private'
      @user.update(private_account: @user.private_account != true)
      respond_to do |format|
        format.js { render 'change_private_button.js.erb', layout: false }
      end
    else
      @user.update(first_name: strong_params[:user][:first_name], last_name: strong_params[:user][:last_name])
      respond_to do |format|
        format.js { render 'edit_name_form.js.erb', layout: false, locals: { user: @user } }
      end
    end
  end

  private

  def strong_params
    params.permit!
  end


end
