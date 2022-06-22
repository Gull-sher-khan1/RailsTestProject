# frozen_string_literal: true

class StoriesController < ApplicationController
  def destroy
    attachment = Attachment.find_by(id: strong_params[:id])
    story = Story.find_by(id: attachment.attachable_id)
    CloudinaryService.destroy(attachment)
    attachment.destroy
    story.destroy
    respond_to do |format|
      format.js { render 'home/reload.js.erb', layout: false }
    end
  end

  private

  def strong_params
    params.permit!
  end
end
