# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_attachment_and_story, only: :destroy

  def destroy
    CloudinaryService.destroy(@attachment)
    redirect_to root_url, alert: 'can not destroy the story' unless @attachment.destroy && @story.destroy
  end

  private

  def strong_params
    params.permit(:id)
  end

  def set_attachment_and_story
    @attachment = Attachment.find_by(id: strong_params[:id])
    @story = Story.find_by(id: @attachment.attachable_id)
    redirect_to root_url, alert: 'can not destroy story' if @attachment.nil? || @story.nil?
  end
end
