class StoriesController < ApplicationController
  before_action :authenticate_user!
  def destroy
    attachment = Attachment.find_by_id(strong_params[:id])
    story = Story.find_by_id(attachment.attachable_id)
    CloudinaryService.destroy(attachment)
    attachment.destroy
    story.destroy
    respond_to do |format|
      format.js {render 'home/reload.js.erb', layout: false}
    end
  end

  private
  def strong_params
    params.permit!
  end
end
