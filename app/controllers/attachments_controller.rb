class AttachmentsController < ApplicationController
  def index
    puts params[:attachments]
  end
  def create
    @attachments = params[:attachment][:attachment]
    p @attachments
    @attachments.each do |file|
      Cloudinary::Uploader.upload(file.tempfile,:folder => "rails_test_project/",)
    end
  end
end
