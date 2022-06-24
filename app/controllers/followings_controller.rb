# frozen_string_literal: true

class FollowingsController < ApplicationController
  layout 'navbar'
  include UserConcern
  before_action :set_search, only: :index
  before_action :set_request, only: [:destroy, :update]

  def index
    @user = current_user
    @following_requests = Following.includes(:user).pending_requests(current_user.id)
    set_followers(@following_requests)
  end

  def create
    @request=Following.create(user_id: strong_params[:user_id],request_accepted: false, follower_id: current_user.id)
    respond_to do |format|
      format.js {render 'change_follow_button.js.erb', layout: false, locals: {from: :create }}
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.js { render strong_params[:from] == 'delete' ? 'remove_request.js.erb' : 'change_follow_button.js.erb', layout: false, locals: {from: :destroy } }
    end
  end

  def update
    @request.update(request_accepted: true)
    respond_to do |format|
      format.js { render 'remove_request.js.erb', layout: false}
    end
  end

  private
  def strong_params
    params.permit(:user_id, :id, :from)
  end

  def set_request
    @request = Following.find_by_id(strong_params[:id])
    render js: "window.location = ' #{helpers.flash_helper('could not complete action, try reloading', :alert)}'" if @request == nil
  end
end
