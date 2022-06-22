# frozen_string_literal: true

class StoryCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    uri = args[0].uri.split('/', -1)
    Cloudinary::Uploader.destroy("rails_test_project/#{uri[uri.size - 1].split('.', -1)[0]}")
    args[0].destroy
    args[1].destroy
  end
end
