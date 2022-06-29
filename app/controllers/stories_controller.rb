# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_attachment_and_story, only: :destroy

  def destroy
    CloudinaryService.destroy(@attachment)
    redirect_to root_url, alert: 'could not destroy the story' if !(@attachment.destroy && @story.destroy)
  end

  private
  def strong_params
    params.permit(:id)
  end

  def set_attachment_and_story
    @attachment = Attachment.find_by_id(strong_params[:id])
    @story = Story.find_by_id(@attachment.attachable_id)
    redirect_to root_url, alert: 'could not destroy story' if @attachment == nil || @story == nil
  end

end
