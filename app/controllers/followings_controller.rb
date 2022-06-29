# frozen_string_literal: true

class FollowingsController < ApplicationController
  layout 'navbar'
  include UserConcern
  before_action :set_search, only: :index
  before_action :set_request, only: %i[destroy update]

  def index
    @user = current_user #remove it
    @following_requests = Following.includes(:user).pending_requests(current_user.id)
    set_followers(@following_requests)
  end

  def create
    @request = Following.create(user_id: strong_params[:user_id], request_accepted: false, follower_id: current_user.id)
    redirect_to root_url, alert: 'request can not be created' if @request.nil?
  end

  def destroy
    redirect_to root_url, alert: 'can not remove request' unless @request.destroy
    @for = strong_params[:from] == 'delete' ? :request : :follow_button
  end

  def update
    redirect_to root_url, alert: 'can not remove request' unless @request.update(request_accepted: true)
  end

  private

  def strong_params
    params.permit(:user_id, :id, :from)
  end

  def set_request
    @request = Following.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'can not complete action, try reloading' if @request.nil?
  end
end
