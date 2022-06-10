class AttachmentsController < ApplicationController
  def index
    puts params[:attachments]
  end
  def create
    @attachments = params[:attachment][:attachment]
    @post = Post.find(params[:post_id])
    @attachments.each do |file|
      res=Cloudinary::Uploader.upload(file.tempfile,:folder => "rails_test_project/", public_id: file.original_filename)
      attachment=@post.attachments.new
      attachment.uri= res["url"]
      attachment.save
    end
  end
end
