class FollowingsController < ApplicationController
  layout 'navbar'
  def index
    @user=User.find(current_user.id)
  end
  def create
    following_request = Following.new
    following_request.user_id = params[:user_id]
    following_request.request_accepted = "pending"
    following_request.follower_id = current_user.id
    following_request.save
    respond_to do |format|
      format.js {render 'change_follow_button.js.erb', layout: false, locals: {request: following_request, from: :create}}
    end
  end
  def destroy
    @request=Following.find(params[:id])
    @request.destroy
    respond_to do |format|
      format.js {render 'change_follow_button.js.erb', layout: false, locals: {request: @request, from: :destroy}}
    end
  end
end
