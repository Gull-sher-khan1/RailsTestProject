class StoriesController < ApplicationController
  def destroy
    attachment = Attachment.find(params[:id])
    story = Story.find(attachment.attachable_id)
    uri = attachment.uri.split('/',-1)
    Cloudinary::Uploader.destroy('rails_test_project/' + uri[uri.size-1].split('.',-1)[0])
    attachment.destroy
    story.destroy
    respond_to do |format|
      format.js {render 'home/reload.js.erb', layout: false}
    end
  end
end
