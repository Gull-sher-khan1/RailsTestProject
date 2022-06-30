# frozen_string_literal: true

module AttachmentConcern
  extend ActiveSupport::Concern

  def from_user?
    strong_params[:from] == 'user'
  end

  def from_post?
    strong_params[:from] == 'post'
  end

  def from_story?
    strong_params[:from] == 'story'
  end
end
