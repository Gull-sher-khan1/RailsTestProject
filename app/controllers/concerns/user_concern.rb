# frozen_string_literal: true

module UserConcern
  extend ActiveSupport::Concern

  def set_users(objects)
    @user_ids = objects.distinct.pluck(:user_id)
    @users = User.where(id: @user_ids).order(id: :asc)
    redirect_to root_url, alert: 'could not find users' if @users.nil?
  end

  def set_followers(objects)
    @user_ids = objects.distinct.pluck(:follower_id)
    @users = User.where(id: @user_ids).order(id: :asc)
    redirect_to root_url, alert: 'could not find users' if @users.nil?
  end

  def set_search
    @search_query = User.ransack(strong_params[:q])
  end
end
