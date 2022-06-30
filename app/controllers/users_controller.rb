# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'navbar'
  include UserConcern
  before_action :set_search, :set_profile_user, :set_likes, :set_user_attachments, only: :show
  before_action :set_user, only: %i[edit update]

  def show
    condition = @profile_user.id == current_user.id || (@profile_user.id != current_user.id && @profile_user.private_account != true)
    @posts = Post.get_posts(@profile_user) if condition
    @posts = Post.none unless condition
    @attachments = Attachment.post_attachments(@posts.get_ids)
  end

  def edit; end

  def update
    if strong_params[:from] == 'private'
      unless @user.update(private_account: @user.private_account != true)
        redirect_to root_url,
                    alert: 'can not perform action'
      end
      @from = :private
    else
      redirect_to root_url, alert: 'can not update user name' unless @user.update(
        first_name: strong_params[:user][:first_name], last_name: strong_params[:user][:last_name]
      )
      @from = :name
    end
  end

  private

  def strong_params
    params.permit(:id, :from, user: %i[first_name last_name])
  end

  def set_profile_user
    @profile_user = User.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not find user' if @profile_user.nil?
  end

  def set_user
    @user = User.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not find user' if @user.nil?
  end

  def set_likes
    @likes_posts = Like.includes(:user).posts_like
  end

  def set_user_attachments
    @user_pic = @user_attachments = Attachment.users_attachments([@profile_user.id])
  end
end
