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
          p res=Cloudinary::Uploader.upload(attachment.tempfile,:folder => "rails_test_project/")
          user.create_attachment(uri: res['url'])
          respond_to do |format|
            format.js {render 'users/add_pic.js.erb', layout: false, locals: {uri: res['url']}}
          end
      end
    end
  end
end
