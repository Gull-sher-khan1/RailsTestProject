# frozen_string_literal: true

class FollowingsController < ApplicationController
  layout 'navbar'
  include UserConcern
  before_action :set_search, only: :index
  def index
    @user = current_user
    @following_requests = Following.pending_requests(current_user.id)
    set_followers(@following_requests)
  end

  def create
    following_request=Following.create(user_id: strong_params[:user_id],request_accepted: false, follower_id: current_user.id)
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
