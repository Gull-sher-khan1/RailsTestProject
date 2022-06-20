class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def create
    if params.key?('attachment')
      #Attachments upload when post is created
      if params[:from]=='post'
        CloudinaryService.batch_upload(Post.find_by_id(params[:post_id]),params[:attachment][:attachment])
      #Attachments upload when story is created
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
      #Attachments upload when user profile pic is added for first time
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
    #Condition runs when the Uer profile pic is updated such as a new pic is added when a pic is already added in profile of user
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
    #it runs when post is edited first it destroys the attachments from cloudinary then uploads it
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
