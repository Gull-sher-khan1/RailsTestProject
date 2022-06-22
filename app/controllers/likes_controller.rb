# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @obj = Post.find_by(id: strong_params[:likeable_id]) if strong_params[:from] == 'post'
    @like = @obj.likes.new
    @like.user_id = strong_params[:user_id]
    @like.save
    respond_to do |format|
      format.js do
        render 'home/change_like.js.erb', layout: false, locals: { like_id: [@like.id], post: @obj, from: :create }
      end
    end
  end

  def destroy
    like = Like.find_by(id: strong_params[:id])
    @obj = Post.find_by(id: like.likeable_id)
    like.destroy
    respond_to do |format|
      format.js { render 'home/change_like.js.erb', layout: false, locals: { post: @obj, from: :destroy } }
    end
  end

  private

  def strong_params
    params.permit!
  end
end
