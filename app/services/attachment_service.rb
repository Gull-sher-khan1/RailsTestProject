# frozen_string_literal: true

class AttachmentService
  def self.create(attachment, story, attachment_parameter)
    attachment = story.build_attachment
    attachment.uri = CloudinaryService.upload(attachment_parameter)
    StoryCleanupJob.set(wait: 60 * 60 * 24).perform_later(attachment, story) if attachment.save
    attachment
  end

  def self.update(attachments, post, attachments_params)
    CloudinaryService.batch_destroy(attachments)
    return if attachments_params.nil?
    CloudinaryService.batch_upload(post,attachments_params)
  end

end
