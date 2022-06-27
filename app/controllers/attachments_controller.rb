# frozen_string_literal: true

class AttachmentsController < ApplicationController
  include AttachmentConcern
  before_action :check, only: :create
  before_action :upload_post_attachments, only: :create, if: :from_post?
  before_action :set_story, only: :create, if: :from_story?
  before_action :set_user, only: :create, if: :from_user?
  after_action :save_story_attachment, only: :create, if: :from_story?
  before_action :update_user_pic, only: :update, if: :from_user?
  before_action :update_post_attachments, only: :update, unless: :from_user?

  def create
    redirect_back(fallback_location: root_path) if strong_params[:from] != 'user'
    @user.create_attachment(uri: @uri) if from_user?
    @attachment = @story.build_attachment if from_story?
  end

  def update
    redirect_back(fallback_location: root_path) if strong_params[:from] != 'user'
    if from_user?
      redirect_to root_url, alert: 'could not update attahcment' unless @attachment.update(uri: @uri)
    end
  end

  private
  def save_story_attachment
    @attachment.uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
    StoryCleanupJob.set(wait: 60 * 60 * 24).perform_later(@attachment, @story) if @attachment.save
  end

  def set_story
    @story = Story.new
    @story.user_id = current_user.id
    redirect_to root_url, alert: 'could not create story' unless @story.save
  end

  def strong_params
    params.permit(:from, :post_id, :user_id, :id, :attachment => {})
  end

  def upload_post_attachments
    @post = Post.find_by_id( strong_params[:post_id])
    redirect_to root_url, alert: 'could not find post' if @post == nil
    CloudinaryService.batch_upload(@post,strong_params[:attachment][:attachment])
  end

  def set_user
    @user = User.find_by(id: strong_params[:user_id])
    redirect_to root_url, alert: 'could not find user' if @user==nil
    @uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
  end

  def update_user_pic
    @attachment = Attachment.find_by(id: strong_params[:id])
    redirect_to root_url, alert: 'could not update attachment' if @attachment == nil || !(CloudinaryService.destroy(@attachment))
    @uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
  end

  def update_post_attachments
    @attachments = Attachment.post_attachments(strong_params[:id])
    redirect_to root_url, alert: 'could not update post' if @attachments==nil
    CloudinaryService.batch_destroy(@attachments)
    check
    @post = Post.find_by_id(strong_params[:id])
    redirect_to root_url, alert: 'could not find post' if @post == nil
    CloudinaryService.batch_upload(@post, strong_params[:attachment][:attachment])
  end

  def check
    return unless params.key?('attachment')

  end

end
