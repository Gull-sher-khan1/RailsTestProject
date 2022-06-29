# frozen_string_literal: true

class AttachmentsController < ApplicationController
  include AttachmentConcern
  before_action :attachment_check, only: :create
  before_action :upload_post_attachments, only: :create, if: :from_post?
  before_action :set_story, only: :create, if: :from_story?
  before_action :set_user, :upload_user_pic, only: :create, if: :from_user?
  before_action :update_user_pic, only: :update, if: :from_user?

  def create
    @user.create_attachment(uri: @uri) if from_user?
    @attachment = AttachmentService.create(@attachment, @story, strong_params[:attachment][:attachment]) if from_story?
    redirect_back(fallback_location: root_path) unless from_user?
  end

  def update
    @post, @attachments = AttachmentService.update(strong_params[:id], params.key?('attachment') ? strong_params[:attachment][:attachment] : nil) unless from_user?
    redirect_back(fallback_location: root_path) unless from_user?
    redirect_to root_url, alert: 'can not update attahcment' if from_user? && !@attachment.update(uri: @uri)
  end

  private

  def set_story
    @story = Story.new
    @story.user_id = current_user.id
  end

  def strong_params
    params.permit(:from, :post_id, :user_id, :id, attachment: {})
  end

  def upload_post_attachments
    @post = Post.find_by(id: strong_params[:post_id])
    redirect_to root_url, alert: 'can not find post' if @post.nil?
    CloudinaryService.batch_upload(@post, strong_params[:attachment][:attachment])
  end

  def set_user
    @user = User.find_by(id: strong_params[:user_id])
    redirect_to root_url, alert: 'can not find user' if @user.nil?
  end

  def upload_user_pic
    @uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
  end

  def update_user_pic
    @attachment = Attachment.find_by(id: strong_params[:id])
    if @attachment.nil? || !CloudinaryService.destroy(@attachment)
      redirect_to root_url,
                  alert: 'can not update attachment'
    end
    @uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
  end

  def attachment_check
    return unless params.key?('attachment')
  end
end
