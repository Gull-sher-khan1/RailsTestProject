class AttachmentsController < ApplicationController
  def index

  end
  def create
    if params.key?('attachment')

      if params[:from]=='post'
        CloudinaryService.batch_upload(Post.find_by_id(params[:post_id]),params[:attachment][:attachment])

      elsif params[:from] == 'story'
        @story = Story.new
        @story.user_id= current_user.id
        if @story.save
          @attachment = @story.build_attachment
          @attachment.uri = CloudinaryService.upload(params[:attachment][:attachment])
          if @attachment.save
            StoryCleanupJob.set(wait: 60*60*24).perform_later(@attachment,@story)
          end
        end

      else
          user = User.find_by_id(params[:user_id])
          uri = CloudinaryService.upload(params[:attachment][:attachment])
          if user.create_attachment(uri: uri)
            respond_to do |format|
              format.js {render 'users/add_pic.js.erb', layout: false, locals: {uri: uri}}
            end
          end
      end

    end
  end
  def update
    if params[:from] == 'user'
      @attachment = Attachment.find_by_id(params[:id])
      if CloudinaryService.destroy(@attachment);
        uri=CloudinaryService.upload(params[:attachment][:attachment])
        if @attachment.update(uri: uri)
          respond_to do |format|
            format.js {render 'users/add_pic.js.erb', layout: false, locals: {uri: uri}}
          end
        end
      end

    else
      @attachments = Attachment.where(attachable_id: params[:id], attachable_type: 'Post')
      CloudinaryService.batch_destroy(@attachments)
      if params.key?('attachment')
        @post = Post.find(params[:id])
        CloudinaryService.batch_upload(@post,params[:attachment][:attachment])
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
