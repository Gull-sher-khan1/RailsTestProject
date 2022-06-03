class LikesController < ApplicationController
  def create
    if(params[:from]=="post")
      @obj=Post.find_by_id(params[:likeable_id])
    end
    @like=@obj.likes.new
    @like.user_id=strong_params[:user_id]
    @like.save
  end
  private
  def strong_params
    params.permit!
  end
end
