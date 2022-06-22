# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def create
    return unless params.key?('attachment')

    case strong_params[:from]
    when 'post'
      CloudinaryService.batch_upload(Post.find_by(id: strong_params[:post_id]),
                                     strong_params[:attachment][:attachment])
      # Attachments upload when story is created
    when 'story'
      @story = Story.new
      @story.user_id = current_user.id
      save_story_attachment if @story.save
    # Attachments upload when user profile pic is added for first time
    else
      user = User.find_by(id: strong_params[:user_id])
      uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
      user.create_attachment(uri: uri)
      respond_to do |format|
        format.js { render 'users/add_pic.js.erb', layout: false, locals: { uri: uri } }
      end
    end
  end

  def update
    # Condition runs when the Uer profile pic is updated such as a new pic is added
    # when a pic is already added in profile of user
    if strong_params[:from] == 'user'
      @attachment = Attachment.find_by(id: strong_params[:id])
      if CloudinaryService.destroy(@attachment)
        uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
        if @attachment.update(uri: uri)
          respond_to do |format|
            format.js { render 'users/add_pic.js.erb', layout: false, locals: { uri: uri } }
          end
        end
      end
    # it runs when post is edited first it destroys the attachments from cloudinary then uploads it
    else
      @attachments = Attachment.post_attachments(strong_params[:id])
      CloudinaryService.batch_destroy(@attachments)
      if strong_params.key?('attachment')
        @post = Post.find(strong_params[:id])
        CloudinaryService.batch_upload(@post, strong_params[:attachment][:attachment])
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private

  def save_story_attachment
    @attachment = @story.build_attachment
    @attachment.uri = CloudinaryService.upload(strong_params[:attachment][:attachment])
    StoryCleanupJob.set(wait: 60 * 60 * 24).perform_later(@attachment, @story) if @attachment.save
  end

  def strong_params
    params.permit!
  end
end
