# frozen_string_literal: true

class FollowingsController < ApplicationController
  layout 'navbar'

  def index
    @search_query = User.ransack(strong_params[:q])
    @user = User.find_by(id: current_user.id)
    @following_requests = Following.includes(:user).where(user_id: current_user.id, request_accepted: false).all
    @user_ids = @following_requests.pluck(:follower_id)
    @users = User.includes(:followings).find(@user_ids)
  end

  def create
    following_request = Following.new
    following_request.user_id = strong_params[:user_id]
    following_request.request_accepted = false
    following_request.follower_id = current_user.id
    following_request.save
    respond_to do |format|
      format.js do
        render 'change_follow_button.js.erb', layout: false, locals: { request: following_request, from: :create }
      end
    end
  end

  def destroy
    @request = Following.find_by(id: strong_params[:id])
    @request.destroy
    if strong_params[:from] == 'delete'
      respond_to do |format|
        format.js { render 'remove_request.js.erb', layout: false, locals: { following_request: @request } }
      end
    else
      respond_to do |format|
        format.js { render 'change_follow_button.js.erb', layout: false, locals: { request: @request, from: :destroy } }
      end
    end
  end

  def update
    @request = Following.find_by(id: strong_params[:id])
    @request.update(request_accepted: true)
    respond_to do |format|
      format.js { render 'remove_request.js.erb', layout: false, locals: { following_request: @request } }
    end
  end

  private

  def strong_params
    params.permit!
  end
end
