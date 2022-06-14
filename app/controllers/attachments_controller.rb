class AttachmentsController < ApplicationController
  def index
    puts params[:attachments]
  end
  def create
    if params.key?('attachment')
      if params[:from]=='post'
        @attachments = params[:attachment][:attachment]
        @post = Post.find(params[:post_id])
        @attachments.each do |file|
          res=Cloudinary::Uploader.upload(file.tempfile,:folder => "rails_test_project/")
          attachment=@post.attachments.new
          attachment.uri= res["url"]
          attachment.save
        end
      else
          user = User.find(params[:user_id])
          attachment = params[:attachment][:attachment]
          res=Cloudinary::Uploader.upload(attachment.tempfile,:folder => "rails_test_project/")
          user.create_attachment(uri: res['url'])
          respond_to do |format|
            format.js {render 'users/add_pic.js.erb', layout: false, locals: {uri: res['url']}}
          end
      end
    end
  end
  def update
    if params[:from] == 'user'
      @attachment = Attachment.find(params[:id])
      attachment = params[:attachment][:attachment]
      uri = @attachment.uri.split('/',-1)
      Cloudinary::Uploader.destroy('rails_test_project/' + uri[uri.size-1].split('.',-1)[0])
      res=Cloudinary::Uploader.upload(attachment.tempfile,:folder => "rails_test_project/")
      @attachment.update(uri: res['url'])
      respond_to do |format|
        format.js {render 'users/add_pic.js.erb', layout: false, locals: {uri: res['url']}}
      end
    else
      @attachments = Attachment.where(attachable_id: params[:id], attachable_type: 'Post')
      @attachments.each do |file|
        uri = file.uri.split('/',-1)
        Cloudinary::Uploader.destroy('rails_test_project/' + uri[uri.size-1].split('.',-1)[0])
        file.destroy
      end
      if params.key?('attachment')
        @attachments = params[:attachment][:attachment]
        @post = Post.find(params[:id])
        @attachments.each do |file|
          res=Cloudinary::Uploader.upload(file.tempfile,:folder => "rails_test_project/")
          attachment=@post.attachments.new
          attachment.uri= res["url"]
          attachment.save
        end
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
